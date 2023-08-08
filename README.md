# Cyclistic-Project
Cyclistic is a company that offers bike-share services. The bikes are geo-tracked and can be unlocked from one station and returned to any other station in the system anytime. Cyclistic runs a flexible pricing plan that offers single-ride passes, full-day passes and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders, while customers who purchase annual memberships are referred to as Cyclistic Members. 
The business has decided to increase the number of Cyclistic Members as a strategy for growth. Rather than creating a marketing campaign targeting all new customers, the Marketing Director believes there is a good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.
## Scenario 
To better understand the customer so that the appropriate marketing programs can be designed, the Marketing director has asked me to analyse the ride data and present insights that will guide marketing activities. The data analysis should answer the following questions. 
#### How do annual members and casual riders use Cyclistic bikes differently?
#### Why would casual riders buy Cyclistic annual memberships?
## The Dataset
The data set contained 12 months from July 2022 to June 2023. The dataset was separated into monthly files containing 13 columns covering ride_ID, bike_type, start date & time, end date & time, start station name, start station ID, end station name, end station ID, start latitude, start longitude, end latitude, end longitude and customer type. 
## Data Preparation
Obtained the 12 CSV files containing data for each month from July 2022 to June 2023. I ensured the CSV files were formatted correctly with appropriate column headers and clean data. I also imported all 12 files into Microsoft SQL for cleaning, transformation and analysis. 
## Data Cleaning and Transformation
Created a table and merged all 12 files into one.  
Removed invalid data and outliers that may skew results. (Outliers were determined based on domain knowledge). 
Cleaned out null values and duplicates.
## Analysis
The database was queried to check for the following
1. Number of Ride Count per Customer Type (Member or Casual)
2. The average ride duration for Annual members and Casual riders
3. Distribution of ride durations for casual riders
4. Number of casual rides with a duration higher than the average ride duration of members
5. The most popular start and end stations for casual riders
6. Usage patterns during weekdays vs weekends for annual members and casual riders
7. Average ride duration per member type and day of the week
8. Usage by time of day
## Visualization
The findings from the analysis were visualised in Tableau. 
https://public.tableau.com/app/profile/hannah.ajiboye/viz/CyclisticProjectJul2022-June2023/Dashboard1 
