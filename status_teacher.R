status_teacher <- function()
{
	source("status.R")

	statuses()

	load("C:\\Users\\Paul\\Paul Maier\\RData\\result.RData")
	load("C:\\Users\\Paul\\Paul Maier\\RData\\school_week.RData")

	teachers <- unique(result$teacher)

	tcount <- length(teachers)

	teacher_status <- matrix(nrow = tcount, ncol = length(school_week))

	colnames(teacher_status) <- school_week

	rownames(teacher_status) <- teachers

	score <- vector(mode="numeric")
	square_pyramid <- vector(mode="numeric")
	percentage <- vector(mode="numeric")

	for (t in 1:tcount)
	{  
		groups <- result$group_id[which(teachers[t] == result$teacher)]
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
			teacher_status[t, w] <- min(status)
			if (teacher_status[t, w] != 7) 
			{
				n <- n + 1
			}
			if (teacher_status[t, w] == 1) 
			{
				points <- points + n
				sp_points <- sp_points + n^2
				sessions <- sessions + 1
			}
		}
		score[t] <- points/((n*(n+1))/2)
		percentage[t] <- sessions/n
		square_pyramid[t] <- sp_points/((2*n^3 + 3*n^2 + n)/6)
	}

	score <- format(score, digits=1)
	square_pyramid <- format(square_pyramid, digits=5)
	percentage <- format(percentage, digits=1)

	teacher_status <- cbind(teacher_status, score)
	teacher_status <- cbind(teacher_status, square_pyramid)
	teacher_status <- cbind(teacher_status, percentage)

	save(teacher_status, file="C:\\Users\\Paul\\Paul Maier\\RData\\teacher_status.RData")
	write.csv(teacher_status, file="C:\\Users\\Paul\\Paul Maier\\RData\\teacher_status.csv")
}
















