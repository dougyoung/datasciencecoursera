library(shiny)
library(ggplot2)
data(diamonds)

diamondsSubset <- diamonds[diamonds$carat < 3, ]

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
       sliderInput('carat',
                   "Carat:",
                   min = 0,
                   max = 3,
                   step = 0.1,
                   value = mean(diamondsSubset$carat)),
       selectInput('cut',
                   "Cut:",
                   choices = sort(levels(diamonds$cut), decreasing = TRUE),
                   selected = names(tail(sort(table(diamonds$cut)), n=1))),
       selectInput('color',
                   "Color:",
                   choices = sort(levels(diamonds$color)),
                   selected = names(tail(sort(table(diamonds$color)), n=1))),
       selectInput('clarity',
                   "Clarity:",
                   choices = sort(levels(diamonds$clarity), decreasing = TRUE),
                   selected = names(tail(sort(table(diamonds$clarity)), n=1))),
       sliderInput('depth',
                   "Depth:",
                   min = 40,
                   max = 80,
                   step = 0.1,
                   value = mean(diamondsSubset$depth)),
       sliderInput('table',
                   "Table:",
                   min = 40,
                   max = 100,
                   step = 0.1,
                   value = mean(diamondsSubset$table))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h1(textOutput('diamondPrice')),
      titlePanel("Predict a diamond's price by its features"),
      h2("Getting started"),
      p("This Shiny App is a demonstration of our ability to predict the price of diamonds based off the historical sale prices of previous diamonds."),
      p("To get started use the inputs on the left-hand side to specify the parameters of a diamond whose price you are interested in and the price will appear above. 
         This prediction is based off a linear regression model where the cost was minimized using least squares."),
      p("Click on any feature header to learn more about that feature."),
      a(h3("Carat"), href='https://www.bluenile.com/education/diamonds/carat-weight', target='_blank'),
      p("Carat is a measure of a diamond's weight."),
      a(h3("Cut"), href='https://www.bluenile.com/education/diamonds/cut', target='_blank'),
      p("A diamond's cut grade is an objective measure of a diamond's light performance, or, what we generally think of as sparkle."),
      a(h3("Color"), href='https://www.bluenile.com/education/diamonds/color', target='_blank'),
      p("Describes a diamond's coloration qualities."),
      a(h3("Clarity"), href='https://www.bluenile.com/education/diamonds/clarity', target='_blank'),
      p("Clarity refers to the tiny, natural imperfections that that are present in all but the rarest diamonds."),
      a(h3("Depth"), href='https://www.jedwardsdiamonds.com/images/table1_lg.jpg', target='_blank'),
      p("Depth describes one physical dimension of a diamond."),
      a(h3("Table"), href='https://www.jedwardsdiamonds.com/images/table1_lg.jpg', target='_blank'),
      p("Table describes one physical dimension of a diamond.")
    )
  )
))
