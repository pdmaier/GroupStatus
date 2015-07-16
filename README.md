### Group Status Functions

Hello! In this project, I created an R script that pulls usage logs from a CSV file, performs calculations on the frequency of the logs, and reports back a CSV that gives a week-by-week status for every group, along with a few usage "scores" that give an idea of the "health" of a group.

The groups in this case are classes using the Adaptemy adaptive learning platform in class, and each log entry is when a class registers an in-class session. However, the logic used in this function can be applied to many other situations where an ongoing status needs to be reported programatically, particularly when this status is dependent on attendance of some kind.

The best way to explore this repo and follow along is to read through the "status.R" function. That's commented up pretty well and serves as the controller for all the other functions. It also would be the one function I would call on the command line in R to run this analysis. The other files in here are the data input and output, the R functions within the status function, and a couple of status functions that calculate the same statuses, but on a teacher and school basis, rather than just on a group basis.

If you're reading this and you're not totally clear on what all this means, please just email me and I'll be glad to explain further. My email is pdmaier@gmail.com.

Thanks for stopping by, and if you have any comments, please do let me know!
