# exploratory data analysis - project 2 - plot 4

# needed libraries / packages
library(ggplot2)
library(dplyr)

# set the correct working dir
setwd("~/Documents/Machine Learning/exploratory data analysis/ExData_Plotting2")

# read in the data (code from the assignment, with altered location to match local data files)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds") 

# filter to keep only coal combustion-related sources
SCC <- SCC %>% filter(grepl(".+Coal$", SCC.Level.Three))
SCC <- SCC %>% filter(grepl("^.+Combustion.+", SCC.Level.One))

# inner join the NEI datset with the SCC filtered set, to keep only the records with the coal combustion related data in the NEI set
NEI <- inner_join(NEI, SCC, by = "SCC")

# create data frame, with dplyr package, calc sum of emissions per year
emisCoalCombPerYear <- NEI %>% group_by(year) %>% summarise(sum(Emissions))

# rename the column names for easy use in plot 
colnames(emisCoalCombPerYear) <- c("year", "emis")

# check the created emissions data in text format for verification
print(emisCoalCombPerYear)

# generate the plot
plot4 <- ggplot(emisCoalCombPerYear, aes(x=year, y=emis)) + 
    geom_line() + 
    geom_point( size=4, shape=21, fill="white") +
    ggtitle("Plot 4 - USA: total PM25 emissions from coal combustion related sources") +
    ylab("emission")

# draw the plot 
print(plot4)

# after drawing save to a png file
ggsave(filename = "plot4.png", plot = plot4, dpi = 100)