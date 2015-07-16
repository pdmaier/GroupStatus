# This function has been made obsolete and is no longer in use for status calculations.

consolidate <- function(logs)
{
	groups <- unique(logs$ID.Group)

	g2s <- data.frame(nrow = length(groups), ncol = 2)

	for (g in 1:length(groups))
	{
		group <- groups[g]

		roll <- as.character(logs$Roll.Number[which(logs$ID.Group == group)])

		g2s[g, 1] <- group

		g2s[g, 2] <- roll[1]
	}
	g2s
}