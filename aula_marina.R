library(shiny)
library(dados)
library(tidyverse)

df <- dados_gapminder

ui <- fluidPage(
  titlePanel("Tributo a Hans Rosling"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(
        "eixox", "Selecione a variável do eixo x",
        c("expectativa_de_vida", "populacao", "pib_per_capita")
      ),
      selectInput(
        "eixoy", "Selecione a variável do eixo y",
        c("expectativa_de_vida", "populacao", "pib_per_capita")
      )
    ),
    mainPanel = mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    df |>
      ggplot(aes(x = .data[[input$eixox]], y = .data[[input$eixoy]])) +
      geom_point() +
      theme_minimal(16)
  })
}

shinyApp(ui, server)
