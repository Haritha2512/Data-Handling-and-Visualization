# Create the survey dataset
survey <- data.frame(
  Survey_ID = c(1, 2, 3),
  Question1 = c("A", "B", "C"),
  Question2 = c("B", "A", "A"),
  Question3 = c("C", "D", "B")
)

print(survey)

par(mar = c(4, 4, 2, 1))

barplot(q1,
        col = "skyblue",
        main = "Distribution of Question 1 Responses",
        xlab = "Responses",
        ylab = "Frequency")

responses <- table(
  Response = c(survey$Question1,
               survey$Question2,
               survey$Question3),
  Question = rep(c("Question1",
                   "Question2",
                   "Question3"),
                 each = nrow(survey))
)

print(responses)

barplot(responses,
        col = c("red", "blue", "green", "yellow"),
        main = "Overall Distribution of Responses",
        xlab = "Questions",
        ylab = "Count",
        legend.text = rownames(responses))

print(survey)

install.packages("shiny")

library(shiny)

survey <- data.frame(
  Survey_ID = c(1,2,3),
  Question1 = c("A","B","C"),
  Question2 = c("B","A","A"),
  Question3 = c("C","D","B")
)

ui <- fluidPage(
  
  titlePanel("Survey Responses Dashboard"),
  
  fluidRow(
    column(6,
           plotOutput("bar1")),
    column(6,
           plotOutput("bar2"))
  ),
  
  fluidRow(
    dataTableOutput("table")
  )
)

server <- function(input, output) {
  
  output$bar1 <- renderPlot({
    
    q1 <- table(survey$Question1)
    
    barplot(q1,
            col="skyblue",
            main="Question 1 Responses",
            xlab="Responses",
            ylab="Frequency")
    
  })
  
  output$bar2 <- renderPlot({
    
    responses <- table(
      Response=c(survey$Question1,
                 survey$Question2,
                 survey$Question3),
      Question=rep(c("Question1",
                     "Question2",
                     "Question3"),
                   each=nrow(survey))
    )
    
    barplot(responses,
            col=rainbow(nrow(responses)),
            main="Overall Survey Responses",
            xlab="Questions",
            ylab="Count",
            legend.text=rownames(responses))
  })
  
  output$table <- renderDataTable({
    survey
  })
  
}

shinyApp(ui, server)

