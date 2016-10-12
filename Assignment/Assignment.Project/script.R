install.packages("plyr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("knitr")

library("plyr")
library("dplyr")
library("ggplot2")
library("knitr")
library("markdown")

download.file("https://d396qusza40orc.cloudfront.net/repdata/data/StormData.csv.bz2", "StormData.csv.bz2")
stormData <- read.csv("StormData.csv.bz2")
head(stormData)

casualties <- ddply(stormData, .(EVTYPE), summarize, fatalities = sum(FATALITIES), injuries = sum(INJURIES))
casualties$totalCasualties <- casualties$fatalities + casualties$injuries
casualties <- casualties[with(casualties, order( - totalCasualties)),][1:5,]
ggplot(casualties, aes(x = EVTYPE, y = totalCasualties)) + geom_bar(stat = "identity", fill = "light blue") + xlab("Event type") + ylab("Total casualties")

damages <- ddply(stormData, .(EVTYPE), summarize, property = sum(PROPDMG), crop = sum(CROPDMG))
damages$totalDamages <- damages$property + damages$crop
damages <- damages[with(damages, order( - totalDamages)),][1:5,]
ggplot(damages, aes(x = EVTYPE, y = totalDamages)) + geom_bar(stat = "identity", fill = "light blue") + xlab("Event type") + ylab("Total damages ($)")

knit("Markdown.rmd")
markdownToHTML('Markdown.md', 'Markdown.html', options = c("use_xhml"))
system("pandoc -s Markdown.html -o Markdown.pdf")