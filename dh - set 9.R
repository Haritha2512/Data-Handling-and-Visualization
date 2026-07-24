install.packages("ggplot2")
library(ggplot2)

product <- data.frame(
  Category = c("Electronics", "Appliances", "Clothing"),
  Sales = c(50000, 40000, 35000)
)

library(ggplot2)

ggplot(product, aes(x = reorder(Category, Sales), y = Sales, fill = Category)) +
  geom_col(width = 0.8) +
  coord_flip() +
  labs(
    title = "Sales Conversion Funnel",
    x = "Product Category",
    y = "Sales ($)"
  ) +
  theme_minimal() +
  guides(fill = "none")

pie(product$Sales,
    labels = product$Category,
    main = "Sales Distribution by Product Category",
    col = rainbow(3))

print(product)

library(shiny)

product <- data.frame(
  Category = c("Electronics","Clothing","Appliances"),
  Sales = c(50000,35000,40000)
)

ui <- fluidPage(
  
  titlePanel("Product Category Analysis"),
  
  fluidRow(
    
    column(6,
           plotOutput("pie")),
    
    column(6,
           plotOutput("bar"))
  ),
  
  fluidRow(
    dataTableOutput("table")
  )
  
)

server <- function(input, output){
  
  output$pie <- renderPlot({
    
    pie(product$Sales,
        labels=product$Category,
        main="Sales Distribution",
        col=rainbow(3))
    
  })
  
  output$bar <- renderPlot({
    
    barplot(product$Sales,
            names.arg=product$Category,
            col="lightblue",
            main="Product Sales",
            xlab="Category",
            ylab="Sales")
    
  })
  
  output$table <- renderDataTable({
    product
  })
  
}

shinyApp(ui,server)