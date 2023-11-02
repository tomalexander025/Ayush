library(shiny)
library(shinydashboard)
library(highcharter)
library(dplyr)
library(plotly) 
library(ggplot2)

# Sample data (Load your data here)
df <- read.csv("D:\\NEW R PRO\\New folder (7)\\shopping_trends_updated.csv")

shinyServer(function(input, output) {
  
  #valuebox 1
  total_rows <- nrow(df)  #variable
  output$value1 <- renderValueBox({
    valueBox(value = total_rows, subtitle = "TOTAL ROWS", icon = icon("table"), color = "navy")
  }) #valuebox 1 over
  
  
  #value box 2
  avg_amount <- mean(df$Amount)  # variable
  output$value2 <- renderValueBox({
    valueBox(value = round(avg_amount, 2), subtitle = "Average Amount Spend", icon = icon("dollar"), color = "olive")
  }) #valuebox 2 over
  
  most_common_item <- df %>%
    count(Item_Purchased) %>%
    slice(1) %>%
    pull(Item_Purchased)
  
  output$value3 <- renderValueBox({
    valueBox(
      value = most_common_item,
      subtitle = paste("Most Common Item Purchased"),
      icon = icon("shopping-cart"), color = "red"
    )
  })
  
  unique_categories <- unique(df$Category)
  output$value4 <- renderValueBox({
    unique_categories_count <- length(unique_categories)
    unique_categories_text <- paste(unique_categories, collapse = ", ")
    valueBox(
      value = unique_categories_count,
      subtitle = paste("Categories:", unique_categories_text),
      icon = icon("tags"), color = "teal"
    )
  })
  
  # Create a bar plot to show which gender does more shopping in each season
  output$genderShoppingPlot <- renderPlotly({
    gender_season <- df %>%
      group_by(Season, Gender) %>%
      summarise(TotalShopping = n())
    
    plot_ly(data = gender_season, x = ~Season, y = ~TotalShopping, color = ~Gender, type = "bar", marker = list(line = list(width = 2))) %>%
      layout(title = "Gender Shopping by Season", xaxis = list(title = "Season"), yaxis = list(title = "Total Shopping"))
  })
  
  # Create a line chart for the average amount spent in each season using highcharter
  output$seasonAmountChart <- renderHighchart({
    season_avg_amount <- df %>%
      group_by(Season) %>%
      summarise(Avg_Amount = mean(Amount))
    
    custom_colors <- "green" # Replace with your desired colors
    
    highchart() %>%
      hc_title(text = "Average Amount Spent by Season") %>%
      hc_xAxis(categories = season_avg_amount$Season) %>%
      hc_yAxis(title = list(text = "Average Amount")) %>%
      hc_add_series(season_avg_amount$Avg_Amount, name = "Average Amount", type = "line") %>%
      hc_colors(custom_colors)  # Set custom colors for the lines
  })
  
  
  
})
