# exploratory data analysis - project 2 - plot 1

# needed libraries / packages
library(dplyr)

# set the correct working dir
setwd("~/Documents/Machine Learning/exploratory data analysis/ExData_Plotting2")

# read in the data (code from the assignment, with altered location to match local data files)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds") # strictly this line of import is not needed for this plot, but it is a small data set compare to the NEI set. 

# create data frame, with dplyr package, calc sum of emissions per year
emisPerYear <- NEI %>% group_by(year) %>% summarise(sum(Emissions))

# rename the column names for easy use in plot 
colnames(emisPerYear) <- c("year","emis")

# check the emissions in text format 
print(emisPerYear)

# draw the plot 
plot(emis ~ year, data=emisPerYear, type="b", xlab = "year", ylab = "PM25 emissions", col="blue", main="Plot 1 - USA: total PM25 emissions per year")

# after drawing, copy and save to a png file
dev.copy(png,'plot1.png')
dev.off()