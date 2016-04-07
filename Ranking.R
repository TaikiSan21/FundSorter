## Playing with xl file for Gerhard
library(xlsx)
library(dplyr)
setwd('~/Downloads')
xlData <- read.xlsx('ALL PRU CHOICE FUNDS.xlsx', 1, as.data.frame = TRUE)

wt1name <- names(xlData)[13]
wt1 <- 0.5
wt2name <- names(xlData)[14]
wt2 <- 0.5
#### Get vector of input names and weight amounts
wtNames <- c(wt1name, wt2name)
wtAmounts <- c(wt1, wt2)

#Init column
xlData['RankAverage'] <- 0
xlData['NormAverage'] <- 0
# Make weights
for(i in seq_along(wtNames)) {
     xlData$RankAverage <- xlData$RankAverage + wtAmounts[i]*rank(-xlData[wtNames[i]])
     xlData$NormAverage <- xlData$NormAverage + 
           wtAmounts[i]*(xlData[[wtNames[i]]] - mean(xlData[[wtNames[i]]], na.rm=TRUE))/sd(xlData[[wtNames[i]]], na.rm=TRUE)
}
# Arrange results
arrange(xlData, RankAverage)[1:10,c('Name', wt1name, wt2name)]
arrange(xlData, desc(NormAverage))[1:10,c('Name', wt1name, wt2name)]

                  
test <- sapply(xlData, class)