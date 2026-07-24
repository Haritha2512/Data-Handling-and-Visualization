geo <- data.frame(
  City = c("City A", "City B", "City C"),
  Population = c(500000, 700000, 600000),
  Avg_Temperature = c(75, 68, 80),
  Elevation = c(1000, 800, 1200)
)

print(geo)

plot(c(1,2,3), c(1,2,3),
     pch = 19,
     col = "blue",
     xlab = "Longitude (Sample)",
     ylab = "Latitude (Sample)",
     main = "Geographic Distribution of Cities")

text(c(1,2,3), c(1,2,3),
     labels = geo$City,
     pos = 3)

plot(geo$Population,
     geo$Avg_Temperature,
     pch = 19,
     col = "red",
     xlab = "Population",
     ylab = "Average Temperature",
     main = "Population vs Average Temperature")

text(geo$Population,
     geo$Avg_Temperature,
     labels = geo$City,
     pos = 3)

View(geo)

library(shiny)

geo <- data.frame(
  City = c("City A","City B","City C"),
  Population = c(500000,700000,600000),
  Avg_Temperature = c(75,68,80),
  Elevation = c(1000,800,1200)
)

ui <- fluidPage(
  
  titlePanel("Geographic Data Dashboard"),
  
  fluidRow(
    column(6, plotOutput("map")),
    column(6, plotOutput("scatter"))
  ),
  
  fluidRow(
    dataTableOutput("table")
  )
)

server <- function(input, output){
  
  output$map <- renderPlot({
    
    plot(c(1,2,3), c(1,2,3),
         pch = 19,
         col = "blue",
         xlab = "Longitude (Sample)",
         ylab = "Latitude (Sample)",
         main = "City Distribution")
    
    text(c(1,2,3), c(1,2,3),
         labels = geo$City,
         pos = 3)
    
  })
  
  output$scatter <- renderPlot({
    
    plot(geo$Population,
         geo$Avg_Temperature,
         pch = 19,
         col = "red",
         xlab = "Population",
         ylab = "Average Temperature",
         main = "Population vs Temperature")
    
    text(geo$Population,
         geo$Avg_Temperature,
         labels = geo$City,
         pos = 3)
    
  })
  
  output$table <- renderDataTable({
    geo
  })
  
}

shinyApp(ui, server)