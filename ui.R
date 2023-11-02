library(shiny)
library(shinydashboard)
library(highcharter)  # Load highcharter library
library(plotly) 
library(ggplot2)


shinyUI(dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("DATASET INFO", tabName = "Page", icon = icon("circle-info"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "Page",
        fluidRow(
          valueBoxOutput("value1"),
          valueBoxOutput("value2"),
          valueBoxOutput("value3"),
          valueBoxOutput("value4")
        ),
        plotlyOutput("genderShoppingPlot"),
        highchartOutput("seasonAmountChart")
      )
    )
  )
))
