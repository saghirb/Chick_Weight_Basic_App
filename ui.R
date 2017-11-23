ui <- fluidPage(
  h2("Chick Weight Data Basic App", align = "center"), br(),
  
  tabsetPanel(
    tabPanel("Raw Data",
             sidebarPanel(
               selectInput("rChick",
                           label = "Chick ID",
                           choices = c("All", unique(CW$Chick))
                           ),
               
               sliderInput("rangeWgt", "Weight Range:",
                           min = rWgt[1], max = rWgt[2],
                           value = c(rWgt[1], rWgt[2])
                           ),
               
               checkboxGroupInput("rDiet",
                                  label = "Diet", 
                                  choices = unique(CW$Diet),
                                  selected = unique(CW$Diet)
                                  ),
               
               checkboxGroupInput("rTime",
                                  label = "Time (days)",
                                  choices = unique(CW$Time),
                                  selected = unique(CW$Time)
                                  )
               ),
             
  mainPanel(
    DT::dataTableOutput("rawtable")
  )),
  
  tabPanel("Summary Stats",
           sidebarPanel(
             checkboxGroupInput("sDiet",
                                label = "Diet",
                                choices = unique(CW_sum_stats$Diet),
                                selected = unique(CW_sum_stats$Diet)
                                ),
             
             checkboxGroupInput("sTime",
                                label = "Time (days)",
                                choices = unique(CW_sum_stats$Time),
                                selected = unique(CW_sum_stats$Time)
                                )
             ),
           
           mainPanel(
             DT::dataTableOutput("sumtable")
           )),
  
  tabPanel("Graphs",
           sidebarPanel(
             radioButtons("plotType", 
                          "Plot type:",
                          choices = c("All diets in one plot", "Plot diets separately"), 
                          selected = c("Plot diets separately"), 
                          inline = FALSE),
             
             checkboxGroupInput("plotShow",
                                label = "Show:",
                                choices = c("Scatter Plot", "Mean Lines", "Box-Whisker Plot"),
                                selected = c("Scatter Plot", "Mean Lines")
                                )
             ),
           
           mainPanel(
            plotOutput("plot")
           )
  ),
  
  tabPanel("About",
           mainPanel(
             column(12, offset = 3, 
                    htmlOutput("aboutData")
                    )
             )
           )
  )
  )

