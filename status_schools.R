status_schools <- function()
{
	source("status.R")

	statuses()

	load("C:\\Users\\Paul\\Paul Maier\\RData\\result.RData")
	load("C:\\Users\\Paul\\Paul Maier\\RData\\school_week.RData")

	schools <- unique(result$school)

	scount <- length(schools)

	school_status <- matrix(nrow = scount, ncol = length(school_week))

	colnames(school_status) <- school_week

	rownames(school_status) <- schools

	score <- vector(mode="numeric")
	square_pyramid <- vector(mode="numeric")
	percentage <- vector(mode="numeric")

	for (s in 1:scount)
	{  
		groups <- result$group_id[which(schools[s] == result$school)]
		points <- 0
		sp_points <- 0
		n <- 0
		sessions <- 0
		for (w in 1:length(school_week))
		{
			status <- NULL
			for (g in 1:length(groups))
			{
				status[g] <- as.numeric(result[which(result$group_id == groups[g]), (w + 3)])
			}
			school_status[s, w] <- min(status)
			if (school_status[s, w] != 7) 
			{
				n <- n + 1
			}
			if (school_status[s, w] == 1) 
			{
				points <- points + n
				sp_points <- sp_points + n^2
				sessions <- sessions + 1
			}
		}
		score[s] <- points/((n*(n+1))/2)
		percentage[s] <- sessions/n
		square_pyramid[s] <- sp_points/((2*n^3 + 3*n^2 + n)/6)
	}

	score <- format(score, digits=1)
	square_pyramid <- format(square_pyramid, digits=5)
	percentage <- format(percentage, digits=1)

	school_status <- cbind(school_status, score)
	school_status <- cbind(school_status, square_pyramid)
	school_status <- cbind(school_status, percentage)

	save(school_status, file="C:\\Users\\Paul\\Paul Maier\\RData\\school_status.RData")
	write.csv(school_status, file="C:\\Users\\Paul\\Paul Maier\\RData\\school_status.csv")
}
















