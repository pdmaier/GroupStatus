pd_api_pull <- function()
{
	library(httr)

	api_url <- "https://api.pipedrive.com/v1/deals?filter_id=45&start=0&limit=500&api_token=ef9fe7b9f8ba78e0d16b992f1fd76dd81072496a"

	raw_data <- GET(api_url)

	json1 <- content(raw_data)

	library(jsonlite)

	json2 <- jsonlite::fromJSON(toJSON(json1))

	json3 <- json2$data

	group_id <- "e49f2426ff1db25271baae466cbc7a6bff20e42b"

	group_to_name_and_school <- cbind(json3$e49f2426ff1db25271baae466cbc7a6bff20e42b, json3$person_id$name, json3$org_name)

	#trim out the entries that have "?" as their ID so matching isn't confused
	gnas <- group_to_name_and_school[which(group_to_name_and_school[,1] != "?"),]

	# coerce this mutant list-thing into a data.frame so it plays nicely
	gnas <- data.frame(gnas)

	colnames(gnas) <- list("group_id", "teacher", "school")

	# change the weird list-like objects into proper columns with values

	gnas$group_id <- as.numeric(gnas$group_id)

	gnas$teacher <- as.character(gnas$teacher)

	gnas$school <- as.character(gnas$school)

	gnas

}