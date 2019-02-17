shinyUI(
  dashboardPage(skin = "black",
  dashboardHeader(title = "TM & News"),
  dashboardSidebar( 
    sidebarMenu(
      menuItem("Descripcion", tabName = "des", icon = icon("dashboard")),
      menuItem("Visualizacion", tabName = "viz", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "des",
              
              h4("Esta aplicacion tiene por objetivo monitorear, las noticias economicas de los
                 principales medios del pais"),
               withMathJax(includeMarkdown("README.md"))
             ),
      
      tabItem(tabName = "viz",
              mainPanel(
                fluidRow(
                  splitLayout(cellWidths = c("50%", "50%"), 
                              box(plotOutput("distPlot1"),width = 12),
                              box(plotOutput("distPlot2"),width = 12))
                )
              )
      )))
    )
)
