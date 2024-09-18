

library(shiny)
library(dados)
library(ggplot2)
library(dplyr)



ui <- fluidPage(
  titlePanel("Hello World!"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      sliderInput(
        inputId = "preco",
        label = "Preço",
        min = 0, max = 20000,
        value = c(1000, 15000)
      )
    ),
    mainPanel = mainPanel(
      plotOutput(
        outputId = "grafico"
      ),
      reactable::reactableOutput(
        outputId = "tabela"
      )
    )
  )
)

server <- function(input, output, session) {


  dados_filtrados <- reactive({

    #browser()

    diamante_filtrado <- diamante |>
      filter(preco >= input$preco[1], preco <= input$preco[2])
    Sys.sleep(3)

    diamante_filtrado
  })

  output$grafico <- renderPlot({

    dados_filtrados() |>
      ggplot(aes(x = preco, y = quilate, color = cor)) +
      geom_point() +
      theme_minimal()

  })


  output$tabela <- reactable::renderReactable({

    dados_filtrados() |>
      reactable::reactable()

  })

}

shinyApp(ui, server)
