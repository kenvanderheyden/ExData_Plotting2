# exploratory data analysis - project 2 - plot 6

# needed libraries / packages
library(ggplot2)
library(dplyr)

# set the correct working dir
setwd("~/Documents/Machine Learning/exploratory data analysis/ExData_Plotting2")

# read in the data (code from the assignment, with altered location to match local data files)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds") 

# filter to keep only coal combustion-related sources
SCC <- SCC %>% filter(grepl("^.+Vehicles.+", SCC.Level.Two))

# filter for the baltimore records 
locations <- c("24510", "06037") 
NEI <- filter(NEI, fips %in% locations)

# inner join the filtered NEI datset with the SCC filtered set, to keep only the records with the coal combustion related data in the NEI set
NEI <- inner_join(NEI, SCC, by = "SCC")

# create data frame, with dplyr package, calc sum of emissions per year
emisCoalCombPerYear <- NEI %>% group_by(year, fips) %>% summarise(sum(Emissions))

# rename the column names for easy use in plot 
colnames(emisCoalCombPerYear) <- c("year", "location", "emis")

# check the created emissions data in text format for verification
print(emisCoalCombPerYear)

# function to rename the facet title labels
mf_labeller <- function(var, value){
    value <- as.character(value)
    if (var=="location") { 
        value[value=="A County"] <- "06037"
        value[value=="24510"]   <- "B Ciry"
    }
    return(value)
}

# generate the plot
plot6 <- ggplot(emisCoalCombPerYear, aes(x=year, y=emis, group=location, color=location)) + 
    geom_line() + 
    geom_point( size=4, shape=21, fill="white") +
    ggtitle("Plot 6 - LA <> Baltimore: total PM25 emissions from motor vehicle sources") +
    ylab("emission") +
    #facet_wrap(~location, labeller=mf_labeller) + 
    facet_wrap(~location, labeller=c("LA County", "B City")) + 
    scale_color_manual("Location\n",labels = c("LA County", "B City"), values = c("red", "green"))

# draw the plot 
print(plot6)

# after drawing save to a png file
ggsave(filename = "plot6.png", plot = plot6, dpi = 100)