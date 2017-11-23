server <- function(input, output) {
  
  # Filter data based on selections
  output$rawtable <- DT::renderDataTable(DT::datatable({
    data <- CW
    if (!("All" %in% input$rChick)) {
      data <- data %>% filter(Chick %in% input$rChick)
      }

    data %>% 
      filter(between(Weight, input$rangeWgt[1], input$rangeWgt[2])) %>%
      filter(Diet %in% input$rDiet) %>% 
      filter(Time %in% input$rTime) %>% 
      arrange(Chick, Diet, Time)
  }, 
  style = "default", rownames = FALSE, options = list(pageLength = 15))
  )
  
  # Filter data based on selections
  output$sumtable <- DT::renderDataTable(DT::datatable({
    data <- CW_sum_stats %>% 
      filter(Diet %in% input$sDiet) %>% 
      filter(Time %in% input$sTime) %>% 
      arrange(Diet, Time)
  }, 
  style = "default", rownames = FALSE, options = list(pageLength = 15)) 
   %>% DT::formatRound(c('Mean', 'SD', 'Median'), digits = c(1, 2, 1)))
 
  
  output$plot <- renderPlot({
    CWplot <- ggplot(CW, aes(as.factor(Time), Weight, colour = Diet)) +
      xlab("Time (days)") + 
      ylab("Weight (grams)") +
      theme(legend.position = "none")

    if ("Plot diets separately" %in% input$plotType) { 
      CWplot <- CWplot + facet_wrap(~Diet) + theme(legend.position = "none")
    }
    else {
      CWplot <- CWplot + theme(legend.position = "bottom")
    }
    
    if ("Box-Whisker Plot" %in% input$plotShow) { 
      CWplot <- CWplot + geom_boxplot(aes(group=interaction(Time, Diet)))
    }
    if ("Scatter Plot" %in% input$plotShow) { 
      CWplot <- CWplot + geom_jitter(size = .4) 
    }
    if ("Mean Lines" %in% input$plotShow ) { 
    CWplot <- CWplot + stat_summary(fun.y="mean", geom="line", aes(group=Diet), size=1)
    }
    print(CWplot)
  }, height = "auto"
  )
  
  #  About the CW Data
  output$aboutData <- renderText(
    paste("<b>The Chick Weight data orginates from the R datasets package. 
    The following is from the help page:</b><br><br>", helpCW)
  )
  
}



