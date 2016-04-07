## shiny server for Gerhard

library(shiny)
library(dplyr)
library(xlsx)
shinyServer(
      function(input, output, session) {
            xlData <- reactive({
                  infile <- input$file1
                  if(is.null(infile)) 
                        return(NULL) 
                  read.xlsx(infile$datapath, 1, as.data.frame = TRUE) })
            ins <- reactiveValues()
            
            observe({
                  ins$wtNames <- c(input$var1, input$var2, input$var3, input$var4)
                  ins$wtAmounts <- c(input$wt1, input$wt2, input$wt3, input$wt4)
                  ins$wtHilo <- c(input$hilo1, input$hilo2, input$hilo3, input$hilo4)
                  ins$myClasses <- c(input$class1)
            })

            
            ranker <- function(data, weights, names, hilo, classes) {
                  # hilo is -1 if higher is better, 1 if lower is better
                  data['RankAverage'] <- 0
                  data['NormAverage'] <- 0
                  if(!is.null(classes)){
                        data <- filter(data, Style.Type %in% classes) }
                  wtsToUse <- c()
                  namesToUse <- c()
                  hilo <- as.numeric(hilo)
                  for(i in seq_along(weights)){
                        if(weights[i] != 0){
                              namesToUse <- append(namesToUse, names[i])
                              wtsToUse <- append(wtsToUse, weights[i])
                        }
                  }
                  for(i in seq_along(wtsToUse)) {
                        data$RankAverage <- data$RankAverage + wtsToUse[i]*rank(hilo[i]*data[namesToUse[i]])
                        data$NormAverage <- data$NormAverage + 
                              wtsToUse[i]*hilo[i]*(data[[namesToUse[i]]] - mean(data[[namesToUse[i]]], na.rm=TRUE))/sd(data[[namesToUse[i]]], na.rm=TRUE)
                  }
                  data[append(c('Name','NormAverage', 'RankAverage', 'Style.Type'), namesToUse)]
            }
            rankTable <- eventReactive( input$goButton, {
                  ranker(xlData(), ins$wtAmounts, ins$wtNames, ins$wtHilo, ins$myClasses) } )
#             rankTable <- eventReactive( input$goButton, {xlData()})
            output$normtable <- renderTable({ select(arrange(rankTable(), NormAverage),
                                                    -c(RankAverage, NormAverage))[1:10,] })
            output$ranktable <- renderTable({ select(arrange(rankTable(), RankAverage),
                                                     -c(RankAverage, NormAverage))[1:10,] })
            #output$testing <- renderText({paste(ins$wtHilo,'maybe')})
            observe({
                  dataClasses <- sapply(xlData(), class)
                  myNames <- names(dataClasses[dataClasses=='numeric'])
                  updateSelectInput(session, 'var1', choices = myNames)
                  updateSelectInput(session, 'var2', choices = myNames)
                  updateSelectInput(session, 'var3', choices = myNames)
                  updateSelectInput(session, 'var4', choices = myNames)
                  updateSelectInput(session, 'class1', choices = levels(xlData()[['Style.Type']]))
            })
      }
)