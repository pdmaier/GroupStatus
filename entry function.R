entry <- function(jc, group, week)
{
	test0 <- which(jc$ID.Group == group & jc$SchoolWeek <= week)

	test1 <- which(jc$ID.Group == group & jc$SchoolWeek == week)

	test2 <- which(jc$ID.Group == group & (jc$SchoolWeek == (week - 2) | jc$SchoolWeek == (week - 1)))

	test3 <- which(jc$ID.Group == group & jc$SchoolWeek > 17 & jc$SchoolWeek < week)

	# Not yet started
	if (length(test0) == 0) 7
	# Last week
	else if (length(test1) > 0) 1
	# Lost
	else if (jc$Status[test0[1]] == "Lost") 6
	# Special
	else if (jc$Special.Chars[test0[1]] != "0") 3
	# Last 3 weeks
	else if (length(test2) > 0) 2
	# This year
	else if (length(test3) > 0) 4
	# Hopefully returning
	else 5
}