statuses <- function()
{

	# load combining and dependent scripts

	source("entry function.R")

	source("consolidate.R")

	# load logs and get only the junior cert records

	logs <- read.csv("Class Logs.csv")
	#logs <- logs[which(logs$Special.Chars != "Northern Ireland Pilot") , ]

	# create vectors of unique id_groups and school weeks

	groups <- unique(logs$ID.Group)
	weeks <- unique(logs$SchoolWeek)

	# little funtion to get the first day of each week, for display on the output titles

	logs_split <- split(logs, logs$SchoolWeek)
	school_week <- sapply(logs_split, function(x) x[1, 16])

	# create matrix for results, set row and col names

	result <- matrix(nrow = length(groups), ncol = length(weeks))
	rownames(result) <- groups
	colnames(result) <- school_week

	# Create matrix for all-time square pyramid scores

	historical_square_pyramid <- matrix(nrow = length(groups), ncol = length(weeks))
	rownames(historical_square_pyramid) <- groups
	colnames(historical_square_pyramid) <- school_week

	# create matrix for all-time linear pyramid score

	historical_pyramid <- matrix(nrow = length(groups), ncol = length(weeks))
	rownames(historical_pyramid) <- groups
	colnames(historical_pyramid) <- school_week

	# create matrix for all-time percentage of classes held

	historical_percentage <- matrix(nrow = length(groups), ncol = length(weeks))
	rownames(historical_percentage) <- groups
	colnames(historical_percentage) <- school_week

	# initialize counter variables for use in calculating group scores

	score <- vector(mode="numeric")
	square_pyramid <- vector(mode="numeric")
	percentage <- vector(mode="numeric")

	# Loop through all groups in all weeks, 
	# use entry function to evaluate each instance, 
	# save instance to result.
	# Also, for each group, after calculating statuses per week,
	# calculate scores for that group.

	for (g in 1:length(groups))
	{
		points <- 0
		sp_points <- 0
		n <- 0
		sessions <- 0
		for (w in 1:length(weeks))
		{
			result[g, w] <- entry(logs, groups[g], weeks[w])
			if (result[g, w] != 7) 
			{
				n <- n + 1
			}
			if (result[g, w] == 1)
			{
				points <- points + n
				sp_points <- sp_points + n^2
				sessions <- sessions + 1
			}
			historical_square_pyramid[g, w] <- sp_points/((2*n^3 + 3*n^2 + n)/6)
			historical_pyramid[g, w] <- points/((n*(n+1))/2)
			historical_percentage[g, w] <- sessions/n
		}
		score[g] <- points/((n*(n+1))/2)
		percentage[g] <- sessions/n
		square_pyramid[g] <- sp_points/((2*n^3 + 3*n^2 + n)/6)
	}

	score <- format(score, digits=1)
	square_pyramid <- format(square_pyramid, digits=5)
	percentage <- format(percentage, digits=1)

	# get information about school and teacher from Pipedrive API

	source("pd_api_pull.R")
	group_teacher_school <- pd_api_pull()

	# stick score column at the end of result

	result <- cbind(result, score)
	result <- cbind(result, square_pyramid)
	result <- cbind(result, percentage)

	# Convert result to a data.frame so all values are numeric and can match to other values

	cols <- colnames(result)

	result <- data.frame(result)

	colnames(result) <- cols

	# put group numbers in a column for easy matching

	group_id <- rownames(result)
	result <- cbind(group_id, result)

	# match up group number to group teacher, school with "group_to_teacher_school"

	result <- merge(group_teacher_school, result, by.x="group_id", by.y="group_id", all.y=TRUE)

	# save variables to file (because saving them to workspace is an even bigger pain)
	save(logs, file="C:\\Users\\Paul\\Paul Maier\\RData\\logs.RData")
	save(result, file="C:\\Users\\Paul\\Paul Maier\\RData\\result.RData")
	save(historical_square_pyramid, file="C:\\Users\\Paul\\Paul Maier\\RData\\historical_square_pyramid.RData")
	save(historical_pyramid, file="C:\\Users\\Paul\\Paul Maier\\RData\\historical_pyramid.RData")
	save(historical_percentage, file="C:\\Users\\Paul\\Paul Maier\\RData\\historical_percentage.RData")
	save(score, file="C:\\Users\\Paul\\Paul Maier\\RData\\score.RData")
	save(school_week, file="C:\\Users\\Paul\\Paul Maier\\RData\\school_week.RData")
  	save(group_teacher_school, file="C:\\Users\\Paul\\Paul Maier\\RData\\group_teacher_school.RData")
	write.csv(result, file="C:\\Users\\Paul\\Paul Maier\\RData\\group_status.csv")
	result
}