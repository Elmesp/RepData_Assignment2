install.packages("plyr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("knitr")

library("plyr")
library("dplyr")
library("ggplot2")
library("knitr")

download.file("https://d396qusza40orc.cloudfront.net/repdata/data/StormData.csv.bz2", "StormData.csv.bz2")
stormData <- read.csv("StormData.csv.bz2")
colnames(stormData)
casualties <- ddply(stormData, .(EVTYPE), summarize, fatalities = sum(FATALITIES), injuries = sum(INJURIES))
casualties$totalCasualties <- casualties$fatalities + casualties$injuries
casualties[which.max(casualties$totalCasualties),]