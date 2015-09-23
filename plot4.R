# exploratory data analysis - project 2 - plot 4

# needed libraries / packages
library(ggplot2)
library(dplyr)

# set the correct working dir
setwd("~/Documents/Machine Learning/exploratory data analysis/ExData_Plotting2")

# read in the data (code from the assignment, with altered location to match local data files)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds") # strictly this line of import is not needed for this plot, but it is a small data set compare to the NEI set. 

NEI <- filter(NEI, fips == "24510")

# create data frame, with dplyr package, calc sum of emissions per year
emisByTypePerYear <- NEI %>% group_by(year, type) %>% summarise(sum(Emissions)) #%>% group_by(type)

# rename the column names for easy use in plot 
colnames(emisByTypePerYear) <- c("year", "type", "emis")

# check the created emissions data in text format for verification
print(emisByTypePerYear)

# generate the plot
plot4 <- ggplot(emisByTypePerYear, aes(x=year, y=emis, group=type, color=type)) + 
    geom_line() + 
    geom_point( size=4, shape=21, fill="white") +
    ggtitle("Plot 4 - USA: total PM25 emissions by type per year") +
    ylab("emission")

# draw the plot 
print(plot4)

# after drawing save to a png file
ggsave(filename = "plot4.png", plot = plot4, dpi = 100)