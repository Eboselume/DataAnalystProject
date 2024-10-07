# COVID-19 Data Analysis Project
## Project Overview
The objective of this project was to analyze COVID-19 data with a focus on understanding trends in deaths and vaccination rates. The analysis aimed to provide insights into the effectiveness of vaccination campaigns and their correlation with COVID-19 death rates across different regions.

## Data Sources
1. SQL Database (Covid Project.sql): This SQL script contains a schema and relevant queries to extract COVID-19-related data from a relational database. It includes tables for patient information, vaccination records, and mortality data.

2. Excel Files:
   *  CovidDeaths.xlsx: This dataset contains records of COVID-19 related deaths, including dates, locations, and demographic information.
    * CovidVaccinations.xlsx: This dataset provides vaccination records, detailing the number of doses administered, types of vaccines, and demographic data.

## Methodology
The analysis followed these key steps:

1. Data Cleaning:
   * Cleaned and preprocessed the datasets by handling missing values, correcting data types, and removing duplicates.
   * Standardized location names and dates for consistency across datasets.

2. Data Exploration:
   * Conducted exploratory data analysis (EDA) to understand the distribution of deaths and vaccinations.
   * Used descriptive statistics to summarize key metrics, such as total deaths, vaccination rates, and demographic breakdowns.

3. SQL Queries:
   * Executed SQL queries to join data from various tables, generating insights into correlations between vaccination rates and COVID-19 death rates.
   * Analyzed trends over time to identify peak periods of vaccination and corresponding changes in death rates.

## Key Findings

* Correlation Between Vaccination and Death Rates:
   * A significant inverse correlation was found between vaccination rates and the number of deaths reported in regions where vaccination campaigns were robust.
    * Regions with high vaccination coverage experienced a marked decrease in COVID-19 related deaths during subsequent waves of infections.

* Demographic Insights:
   * Certain demographic groups, particularly the elderly and those with pre-existing conditions, were disproportionately affected by COVID-19.
   * Vaccination campaigns targeted towards these vulnerable groups showed positive results in reducing death rates.

* Temporal Trends:
   * The analysis identified specific time periods where vaccination efforts were most successful, which corresponded to lower death rates.
   * A spike in vaccination was noted following the introduction of new vaccine types, suggesting public receptiveness to new options.

## Tools and Technologies
* SQL: For data extraction and querying from relational databases.
* Python: For data manipulation, analysis, and visualization (Pandas, Matplotlib, Seaborn).
* Excel: For handling datasets and performing initial analysis.
* Tableau: (if applicable) for creating interactive dashboards to present findings.

## Conclusion
This project not only highlighted the importance of vaccination in managing the COVID-19 pandemic but also emphasized the value of data-driven insights in public health decision-making. By correlating vaccination rates with mortality data, this analysis provides a framework for future research and policy formulation aimed at controlling infectious diseases.

## Future Work
* Extend the analysis to include long-term effects of vaccination on other health outcomes.
* Incorporate more granular data, such as socio-economic factors, to better understand disparities in vaccination and death rates.
* Develop a predictive model to forecast potential out



