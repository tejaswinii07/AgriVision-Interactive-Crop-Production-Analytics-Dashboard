library(shiny)
library(shinydashboard)
library(readr)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)

# Load Dataset
crop_data <- read_csv("crop_production.csv")

# ---------------- UI ----------------

ui <- dashboardPage(
  
  skin = "green",
  
  dashboardHeader(
    title = "🌾 AgriVision"
  ),
  
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem(
        "Home",
        tabName = "home",
        icon = icon("home")
      ),
      
      menuItem(
        "Dashboard",
        tabName = "dashboard",
        icon = icon("dashboard")
      ),
      
      menuItem(
        "Visualizations",
        tabName = "visual",
        icon = icon("chart-bar")
      ),
      
      menuItem(
        "Analytics",
        tabName = "analytics",
        icon = icon("chart-line")
      ),
      
      menuItem(
        "Download",
        tabName = "download",
        icon = icon("download")
      )
      
    )
    
  ),
  
  dashboardBody(
    
    tabItems(
      
      # ================= HOME =================
      
      tabItem(
        
        tabName = "home",
        
        tags$img(
          src = "farm.jpg",
          width = "100%",
          style = "border-radius:10px; max-height:350px; object-fit:cover;"
        ),
        
        br(),
        br(),
        
        fluidRow(
          
          box(
            width = 12,
            status = "success",
            solidHeader = TRUE,
            title = "🌾 AgriVision: Interactive Crop Production Analytics Dashboard",
            
            h3("Welcome to AgriVision"),
            
            p("AgriVision is an interactive agricultural analytics dashboard developed using R Shiny. It enables users to explore crop production trends across Indian States and Union Territories using dynamic filters, interactive charts, and insightful analytics."),
            
            br(),
            
            p("Select a crop, state, and year to begin exploring agricultural production data.")
          )
            
        ),
        
        fluidRow(
          
          infoBox(
            "Total Crops",
            length(unique(crop_data$Crop)),
            icon = icon("seedling"),
            color = "green"
          ),
          
          infoBox(
            "States",
            length(unique(crop_data$State)),
            icon = icon("map"),
            color = "blue"
          ),
          
          infoBox(
            "Years",
            length(unique(crop_data$Year)),
            icon = icon("calendar"),
            color = "purple"
          )
          
        )
        
        
      ),
      
      # ================= DASHBOARD =================
      
      tabItem(
        
        tabName = "dashboard",
        
        fluidRow(
          
          valueBoxOutput("totalProduction", width = 4),
          
          valueBoxOutput("yearBox", width = 4),
          
          valueBoxOutput("stateBox", width = 4)
          
        ),
        
        fluidRow(
          
          valueBoxOutput("soilBox", width = 4),
          
          valueBoxOutput("waterBox", width = 4),
          
          valueBoxOutput("climateBox", width = 4)
          
        ),
        
        box(
          
          title = "Search Crop",
          status = "success",
          solidHeader = TRUE,
          width = 12,
          
          selectInput(
            "crop",
            "Select Crop",
            choices = sort(unique(crop_data$Crop))
          ),
          
          selectInput(
            "state",
            "Select State",
            choices = c("All", sort(unique(crop_data$State)))
          ),
          
          selectInput(
            "year",
            "Select Year",
            choices = c("All", sort(unique(crop_data$Year)))
          ),
          
          actionButton(
            "search",
            "Search",
            icon = icon("search")
          )
          
        ),
        
        box(
          
          title = "Crop Details",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          
          DTOutput("cropTable")
          
        )
        
      ),
      # ================= VISUALIZATIONS =================
      
      tabItem(
        
        tabName = "visual",
        
        box(
          
          title = "Production Bar Chart",
          status = "success",
          solidHeader = TRUE,
          width = 12,
          
          plotlyOutput("cropPlot", height = 350)
          
        ),
        
        box(
          
          title = "Production Trend",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          
          plotOutput("trendPlot", height = 350)
          
        ),
        
        box(
          
          title = "Production by Year",
          
          status = "warning",
          
          solidHeader = TRUE,
          
          width = 12,
          
          plotlyOutput("yearBarPlot", height = 450)
          
        )
        
        
      ),
      
      # ================= ANALYTICS =================
      
      tabItem(
        
        tabName = "analytics",
        
        fluidRow(
          
          valueBoxOutput("cropCount", width = 3),
          
          valueBoxOutput("stateCount", width = 3),
          
          valueBoxOutput("avgYield", width = 3),
          
          valueBoxOutput("totalProductionAll", width = 3)
          
        ),
        
        box(
          
          title = "Top 5 Producing States",
          status = "success",
          solidHeader = TRUE,
          width = 12,
          
          tableOutput("topStates")
          
        )
        
      ),
      
      
      # ================= DOWNLOAD =================
      
      tabItem(
        
        tabName = "download",
        
        fluidRow(
          
          box(
            
            title = "Download Crop Report",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            
            h3("Download Filtered Crop Report"),
            
            p("Click the button below to download the filtered crop data as a CSV file."),
            
            br(),
            
            downloadButton(
              "downloadData",
              "Download CSV Report"
            )
            
          )
          
        ),
        
        fluidRow(
          
          box(
            
            title = "About This Project",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            
            h4("Crop Production Analysis Dashboard"),
            
            p("Developed using R Shiny"),
            
            p("Dataset: Crop Production"),
            
            p("Developer: Tejaswini"),
            
            p("Department: B.Tech Artificial Intelligence and Data Science")
            
          )
          
        )
        
      )
      
    )   # End tabItems
    
  )  # End dashboardBody
  
)       # End dashboardPage


# ---------------- SERVER ----------------

server <- function(input, output) {
  
  # ---------------- FILTER DATA ----------------
  
  result <- eventReactive(input$search, {
    
    data <- crop_data %>%
      filter(Crop == input$crop)
    
    if (input$state != "All") {
      data <- data %>%
        filter(State == input$state)
    }
    
    if (input$year != "All") {
      data <- data %>%
        filter(Year == as.numeric(input$year))
    }
    
    data
    
  })
  
  # ---------------- TABLE ----------------
  
  output$cropTable <- renderDT({
    
    req(result())
    
    datatable(
      
      result(),
      
      options = list(
        pageLength = 10,
        lengthChange = FALSE,
        info = FALSE,
        scrollX = TRUE
      )
      
    )
    
  })
  
  # ---------------- VALUE BOXES ----------------
  output$totalProduction <- renderValueBox({
    
    req(result())
    
    valueBox(
      paste(sum(result()$Production_Tonnes), "Tonnes"),
      "Total Production",
      icon = icon("leaf"),
      color = "green"
    )
    
  })
  
  output$yearBox <- renderValueBox({
    
    req(result())
    
    valueBox(
      max(result()$Year),
      "Latest Year",
      icon = icon("calendar"),
      color = "blue"
    )
    
  })
  
  output$stateBox <- renderValueBox({
    
    req(result())
    
    valueBox(
      ifelse(input$state == "All", "Multiple", input$state),
      "Selected State",
      icon = icon("map"),
      color = "yellow"
    )
    
  })
  
  output$soilBox <- renderValueBox({
    
    req(result())
    
    valueBox(
      unique(result()$Soil_Type)[1],
      "Soil Type",
      icon = icon("seedling"),
      color = "olive"
    )
    
  })
  
  output$waterBox <- renderValueBox({
    
    req(result())
    
    valueBox(
      unique(result()$Water_Requirement)[1],
      "Water Requirement",
      icon = icon("tint"),
      color = "aqua"
    )
    
  })
  
  output$climateBox <- renderValueBox({
    
    req(result())
    
    valueBox(
      unique(result()$Climate)[1],
      "Climate",
      icon = icon("cloud-sun"),
      color = "purple"
    )
    
  })
  
  # ---------------- BAR CHART ----------------
  
  output$cropPlot <- renderPlotly({
    
    req(result())
    
    p <- ggplot(
      result(),
      aes(
        x = factor(Year),
        y = Production_Tonnes,
        fill = factor(Year)
      )
    ) +
      geom_col() +
      labs(
        title = "Crop Production",
        x = "Year",
        y = "Production (Tonnes)"
      ) +
      theme_minimal()
    
    ggplotly(p)
    
  })
  
  # ---------------- TREND CHART ----------------
  
  output$trendPlot <- renderPlot({
    
    req(result())
    
    trend <- result() %>%
      group_by(Year) %>%
      summarise(
        Total = sum(Production_Tonnes),
        .groups = "drop"
      )
    
    ggplot(
      trend,
      aes(
        x = Year,
        y = Total
      )
    ) +
      geom_line(color = "blue", linewidth = 1.3) +
      geom_point(color = "red", size = 3) +
      labs(
        title = "Production Trend",
        x = "Year",
        y = "Production"
      ) +
      theme_minimal()
    
  })
  
  # ---------------- PIE CHART ----------------
  
  output$yearBarPlot <- renderPlotly({
    
    req(result())
    
    year_data <- result() %>%
      group_by(Year) %>%
      summarise(
        Production = sum(Production_Tonnes),
        .groups = "drop"
      ) %>%
      arrange(desc(Production))
    
    p <- ggplot(
      year_data,
      aes(
        x = reorder(as.character(Year), Production),
        y = Production,
        fill = Production
      )
    ) +
      
      geom_col(show.legend = FALSE) +
      
      coord_flip() +
      
      labs(
        title = "Production by Year",
        x = "Year",
        y = "Production (Tonnes)"
      ) +
      
      theme_minimal(base_size = 14)
    
    ggplotly(p)
    
  })
  
  # ---------------- ANALYTICS ----------------
  
  output$cropCount <- renderValueBox({
    
    valueBox(
      length(unique(crop_data$Crop)),
      "Total Crops",
      icon = icon("seedling"),
      color = "green"
    )
    
  })
  
  output$stateCount <- renderValueBox({
    
    valueBox(
      length(unique(crop_data$State)),
      "Total States",
      icon = icon("map"),
      color = "blue"
    )
    
  })
  
  output$avgYield <- renderValueBox({
    
    valueBox(
      round(mean(crop_data$Yield_t_per_ha), 2),
      "Average Yield",
      icon = icon("chart-line"),
      color = "yellow"
    )
    
  })
  
  output$totalProductionAll <- renderValueBox({
    
    valueBox(
      format(sum(crop_data$Production_Tonnes), big.mark = ","),
      "Overall Production",
      icon = icon("tractor"),
      color = "red"
    )
    
  })
  
  # ---------------- TOP 5 STATES ----------------
  
  output$topStates <- renderTable({
    
    crop_data %>%
      group_by(State) %>%
      summarise(
        Total_Production = sum(Production_Tonnes),
        .groups = "drop"
      ) %>%
      arrange(desc(Total_Production)) %>%
      slice(1:5)
    
  })
  
  # ---------------- DOWNLOAD ----------------
  
  output$downloadData <- downloadHandler(
    
    filename = function() {
      paste0("Crop_Report_", Sys.Date(), ".csv")
    },
    
    content = function(file) {
      write.csv(result(), file, row.names = FALSE)
    }
    
  )
  
}

# ---------------- RUN APP ----------------

shinyApp(ui, server)