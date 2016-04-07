## shiny ui for Gerhard
library(shiny)


shinyUI(fluidPage(
      title='Custom Fund Ranking',
      fluidRow(
            column(4, h2('Inputs'),
                   fluidRow(
                         fileInput('file1', 'Choose Excel File:')
                   ),
                   fluidRow(
                         column(6,
                              selectInput('var1', 'First Factor', choices = 'Upload a file')),
                         column(3,
                               numericInput('wt1', 'Wt 1', value = 1, min = 0, max = 1, step = 0.1)),
                         column(3,
                                br(),
                               radioButtons('hilo1',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE))),
                   fluidRow(
                         column(6,
                                selectInput('var2', 'Second Factor', choices = 'Upload a file')),
                         column(3,
                                numericInput('wt2', 'Wt 2', value = 0, min = 0, max = 1, step = 0.1)),
                         column(3,
                                br(),
                                radioButtons('hilo2',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE))),
                   fluidRow(
                         column(6,
                                selectInput('var3', 'Third Factor', choices = 'Upload a file')),
                         column(3,
                                numericInput('wt3', 'Wt 3', value = 0, min = 0, max = 1, step = 0.1)),
                         column(3,
                                br(),
                                radioButtons('hilo3',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE))),
                   fluidRow(
                         column(6,
                                selectInput('var4', 'Fourth Factor', choices = 'Upload a file')),
                         column(3,
                                numericInput('wt4', 'Wt 4', value = 0, min = 0, max = 1, step = 0.1)),
                         column(3,
                                br(),
                                radioButtons('hilo4',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE))),
#                          column(6, h4('Select Factors'),
#                                 selectInput('var1', 'First Factor', choices = 'Upload a file'),
#                                 selectInput('var2', 'Second Factor', choices = 'Upload a file'),
#                                 selectInput('var3', 'Third Factor', choices = 'Upload a file'),
#                                 selectInput('var4', 'Fourth Factor', choices = 'Upload a file')),
#                          column(3, h4('Weights'),
#                                 numericInput('wt1', 'Wt 1', value = 1, min = 0, max = 1, step = 0.1),
#                                 numericInput('wt2', 'Wt 2', value = 0, min = 0, max = 1, step = 0.1),
#                                 numericInput('wt3', 'Wt 3', value = 0, min = 0, max = 1, step = 0.1),
#                                 numericInput('wt4', 'Wt 4', value = 0, min = 0, max = 1, step = 0.1)),
#                          column(3, h4('Better is:'),
#                                 radioButtons('hilo1',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE),
#                                 br(),
#                                 radioButtons('hilo2',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE),
#                                 br(),
#                                 radioButtons('hilo3',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE),
#                                 br(),
#                                 radioButtons('hilo4',label=NULL, choices=c('Hi' = -1, 'Lo' = 1), inline=TRUE))),
                   fluidRow(
                         column(11, offset=0,
                                selectInput('class1', 'Select Fund Style', choices = 'Upload a file', multiple=TRUE, selectize=TRUE))),
                   fluidRow(
                         column(11, offset=0, h4('Click to get rankings'),
                                actionButton('goButton', 'Clicky!'))),
                  fluidRow(
                        h3('Usage Notes:'),
                        h5('Upload the excel file with the funds. The fund style must always be labeled Style Type and the fund name must be labeled Name in the Excel file.'),
                        h5('Choose the factors you want to sort by, then assign a weight. The weights dont have to add to 1, so 0.5 and 0.5 has the same result as 1 and 1.'),
                        h5('You will only to be able to select columns that are numbers.'),
                        h5('Any factor with a weight of zero will not be used at all.'),
                        h5('Choose Hi if you want that factor to have a high value, Lo if you want it to be low.'),
                        h5('Choose the fund styles you want to include. You can select multiple styles, and delete selections with backspace.'),
                        h5('If no style is chosen, all fund styles will be used.'))
                                 
            ),
            column(8, h2('Outputs'),
                   h4('Normalized Ranking'),
                   tableOutput('normtable'),
                   h4('Averaged Rank'),
                   tableOutput('ranktable'))
      )
)
)