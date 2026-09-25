# AgriVision: Interactive Crop Production Analytics Dashboard

## About the Project

AgriVision is an interactive R Shiny dashboard developed to analyze and visualize crop production data across Indian States and Union Territories. The application allows users to explore agricultural data using crop, state, and year-based filters.

The dashboard presents important agricultural information through interactive charts, summary boxes, tables, and analytics.

## Features

* Interactive crop, state, and year selection
* Crop production analysis
* Year-wise production trends
* State-wise production analysis
* Production comparison using bar charts
* Horizontal bar chart for clearer year-wise comparison
* Average yield analysis
* Soil type information
* Climate information
* Water requirement information
* Fertilizer information
* Top-producing state analysis
* Filtered data download as CSV
* User-friendly dashboard interface

## Dataset

The project uses a CSV dataset named:

```text
crop_production.csv
```

The dataset contains the following fields:

```text
State
District
Crop
Season
Year
Area_Hectares
Production_Tonnes
Yield_t_per_ha
Soil_Type
Water_Requirement
Climate
Fertilizer
```

The dataset covers the period from **2016 to 2025** and contains agricultural information for Indian States and Union Territories.

## Technologies Used

* R
* R Shiny
* shinydashboard
* dplyr
* readr
* ggplot2
* Plotly

## Project Structure

```text
AgriVision/
│
├── app.R
├── crop_production.csv
├── README.md
│
└── www/
    └── farm.jpg
```

## How to Run the Project

### 1. Install R

Install R on your computer.

### 2. Install RStudio

Open the project using RStudio.

### 3. Install Required Packages

Run the following command in the R console:

```r
install.packages(c(
  "shiny",
  "shinydashboard",
  "readr",
  "dplyr",
  "ggplot2",
  "plotly"
))
```

### 4. Add the Dataset

Place the following file in the same folder as `app.R`:

```text
crop_production.csv
```

### 5. Add the Image

Place the dashboard image inside the `www` folder:

```text
www/farm.jpg
```

### 6. Run the Application

Open `app.R` in RStudio and click:

**Run App**

The AgriVision dashboard will open in your web browser.

## Dashboard Sections

### Home

Provides an introduction to AgriVision along with basic dataset statistics.

### Dashboard

Allows users to select a crop, state, and year and view the corresponding agricultural records.

### Visualizations

Displays production charts and trends for easier data interpretation.

### Analytics

Provides overall statistics and identifies top-producing states.

### Download

Allows users to download filtered crop production data as a CSV file.

## Project Objective

The main objective of AgriVision is to transform agricultural data into an interactive and easy-to-understand visual analytics platform using R Shiny.

## Future Enhancements

Possible future improvements include:

* Interactive India production map
* District-level analysis
* Weather and rainfall integration
* Market price analysis
* Crop recommendation
* Crop production prediction using machine learning
* Additional agricultural datasets

## Author

**Tejaswini B**

**B.Tech Artificial Intelligence and Data Science**

## Project Title

**AgriVision: Interactive Crop Production Analytics Dashboard**
