# exploratory data analysis - project 2 - plot 1

# set the correct working dir
setwd("~/Documents/Machine Learning/exploratory data analysis/ExData_Plotting2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# create data frame, with dplyr package, calc sum of emissions per year
emisPerYear <- NEI %>% group_by(year) %>% summarise(sum(Emissions))

# rename the column names for easy use in plot 
colnames(emisPerYear) <- c("year","emis")

# check the emissions in text format 
print(emisPerYear)

# draw the plot 
plot(emis ~ year, data=emisPerYear, type="b", xlab = "year", ylab = "total emissions", col="blue")

# after drawing, copy and save to a png file
dev.copy(png,'plot1.png')
dev.off()