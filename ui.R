ui <- fluidPage(
  h2("Chick Weight Data Basic App", align = "center"), br(),
  
  tabsetPanel(
    tabPanel("Raw Data",
             sidebarPanel(
               selectizeInput("rChick",
                              label = "Chick IDs",
                              choices = unique(CW$Chick),
                              selected = unique(CW$Chick),
                              multiple = TRUE,
                              options = list(placeholder = "Select Chick IDs")
                              ),
               
               selectizeInput("rDiet",
                              label = "Diets", 
                              choices = unique(CW$Diet),
                              selected = unique(CW$Diet),
                              multiple = TRUE,
                              options = list(placeholder = "Select Diets")
                              ),
               
               selectizeInput("rTime",
                              label = "Time (days)",
                              choices = unique(CW$Time),
                              selected = unique(CW$Time),
                              multiple = TRUE,
                              options = list(placeholder = "Select Time")                                  
                                  ),
               
               sliderInput("rangeWgt", "Weight Range:",
                           min = rWgt[1], max = rWgt[2],
                           value = c(rWgt[1], rWgt[2])
                           )
               ),
             
  mainPanel(
    DT::dataTableOutput("rawtable")
  )),
  
  tabPanel("Summary Stats",
           sidebarPanel(
             selectizeInput("sDiet",
                            label = "Diets", 
                            choices = unique(CW_sum_stats$Diet),
                            selected = unique(CW_sum_stats$Diet),
                            multiple = TRUE,
                            options = list(placeholder = "Select Diets")
                            ),
             
             selectizeInput("sTime",
                            label = "Time (days)",
                            choices = unique(CW_sum_stats$Time),
                            selected = unique(CW_sum_stats$Time),
                            multiple = TRUE,
                            options = list(placeholder = "Select Time")                                  
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
  
  tabPanel("R Help",
           mainPanel(
             column(12, offset = 3, 
                    htmlOutput("RHelp")
                    )
             )
           )
  )
  )

