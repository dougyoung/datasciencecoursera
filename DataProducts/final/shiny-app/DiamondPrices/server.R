library(shiny)
library(ggplot2)
data(diamonds)

# Fit a linear model to the diamonds data
diamondsSubset <- diamonds[
  diamonds$carat < 3 &
    diamonds$y < 10 &
    diamonds$z > 2 & diamonds$z < 10,
]
fit <- 
  lm(price ~ carat + cut + color + clarity + depth + table, data=diamondsSubset)

shinyServer(function(input, output) {
   
  output$diamondPrice <- renderText({
    price = predict(fit, newdata=data.frame(
      carat=input$carat,
      cut=input$cut,
      color=input$color,
      clarity=input$clarity,
      depth=input$depth,
      table=input$table
    ))
    paste0("Predicted price in USD: $", round(price, digits=2))
  })
  
})
