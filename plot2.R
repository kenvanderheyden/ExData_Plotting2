# exploratory data analysis - project 2 - plot 2

# set the correct working dir
setwd("~/Documents/Machine Learning/exploratory data analysis/ExData_Plotting2")

# read in the data (code from the assignment, with altered location to match local data files)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds") # strictly this line of import is not needed for this plot, but it is a small data set compare to the NEI set. 

NEI <- filter(NEI, fips == "24510")

# create data frame, with dplyr package, calc sum of emissions per year
emisPerYear <- NEI %>% group_by(year) %>% summarise(sum(Emissions))

# rename the column names for easy use in plot 
colnames(emisPerYear) <- c("year","emis")

# check the emissions in text format 
print(emisPerYear)

# draw the plot 
plot(emis ~ year, data=emisPerYear, type="b", xlab = "year", ylab = "total emissions", col="red", main="Plot 2 - Baltimore City: total emissions per year")

# after drawing, copy and save to a png file
dev.copy(png,'plot2.png')
dev.off()