##Project 1: Geospatial Analysis
##Tace Harris
---------------------------------------------------------------------------
##Set Working Directory 
setwd("/Users/taceharris/Desktop/QMSS 301/Project 1")

##Load in Packages
library(sf)
library (tmap)
library(dplyr)

##Read in Data
community_areas <- st_read ("communities.shp")
zip_codes <- st_read ("zip_codes.shp")
crime_data <- read.csv('crimes1.csv')
school_location <- st_read ("schools.shp")

###Task 1
##Step 1
#Make Zip Codes Projected
zip_codes_pj <- st_transform(zip_codes,crs = 3435)

#Make Crime Data a Shape File
colnames(crime_data) #Check where long/lat is stored and by what name
crime_data_longlat <- st_as_sf(crime_data, coords= c('Longitude', 'Latitude'))
st_crs(crime_data_longlat) <- 4326 

#Make Crime Data Projected
crime_data_pj <- st_transform(crime_data_longlat, crs = 3435)

#Determine what crimes fall within each zip code
crimes_by_zip <- st_within(crime_data_pj, zip_codes_pj, sparse = FALSE)

#Sum the number of crimes within each zip code
crime_count_by_zip <- apply(X = crimes_by_zip, MARGIN=2, FUN=sum)  

#Bind the crime counts back with the zip code data, so that they are in the same file
zip_codes_pj <- cbind(zip_codes_pj, crime_count_by_zip)

#Find the median crime count by zip
summary(zip_codes_pj) #Median = 2767

#Make the median an object
median_crimes <- 2767

#Classify zip codes as high or low risk based on median crime count
crime_count_by_risk <- zip_codes_pj %>%
  mutate(risk_level = ifelse(crime_count_by_zip > median_crimes, "High", "Low"))

#Map Data
tmap_mode("plot") #Set to Plotting Mode

#Make the map have zip codes green for low risk, red for high risk, and zip code labels
tm_shape(crime_count_by_risk) + #Select where the data is being pulled from
  tm_borders() +  
  tm_fill(col = "risk_level", palette = c("red", "green"), style = "cat", legend.show = TRUE) +  #Color the polygon/zip code by risk level
  tm_text(text = "zip", size = 0.5, col = "black") + #Label the zip codes
  tm_layout(legend.position = c("right", "top")) + #Add the legend
tm_layout(main.title = "Chicago Zip Codes by Crime Risk Level", #Add the title
          main.title.position = "center",
          main.title.size = 1,
          frame = FALSE)

##Step 2
st_is_longlat(community_areas) #Check if it is projected or unprojected, and it said TRUE so it is unprojected

#Transform the data to projected
community_areas_pj <- st_transform(community_areas, crs = 3435)
st_is_longlat(community_areas_pj) #Check it worked, and it said FALSE so it did

#Determine what crimes are in which community
crimes_by_community <- st_within(crime_data_pj, community_areas_pj, sparse = FALSE)

#Sum the number of crimes within each community
crime_count_by_community <- apply(X = crimes_by_community, MARGIN=2, FUN=sum)  

#Bind the crime counts back with the community data, so that they are in the same file
community_areas_pj<- cbind(community_areas_pj, crime_count_by_community)

#Check the bind worked and check the mean
summary(community_areas_pj) #mean is 2250

#Made the median an object
median_crimes_by_community <- 2250

#Sort Communties by Risk Level
community_count_by_risk <- community_areas_pj %>%
  mutate(risk_level = ifelse(crime_count_by_community > median_crimes_by_community, "High", "Low"))
#Map 1
tmap_mode("plot") #Set to Plotting Mode
tm_shape(community_count_by_risk) + #Select where the data is being pulled from
  tm_borders() +  
  tm_fill(col = "risk_level", palette = c("red", "green"), style = "cat", legend.show = TRUE) +  #Color the polygon/zip code by risk level
  tm_text(text = "community", size = 0.5, col = "black") + #Label the zip codes
  tm_layout(legend.position = c("right", "top")) + #Add the legend
  tm_layout(main.title = "Chicago Communities by Crime Risk Level", #Add the title
            main.title.position = "center",
            main.title.size = 1,
            frame = FALSE)

#Find communities with highest and lowest crime rates
highest_crime_community <- community_areas_pj %>% 
  filter(crime_count_by_community == max(crime_count_by_community)) 
 
lowest_crime_community <- community_areas_pj %>% 
  filter(crime_count_by_community == min(crime_count_by_community)) 

#Make Map
tmap_mode("plot") #Set to Plotting Mode

#Make the map
tm_shape(community_areas_pj) + 
  tm_polygons(col = "gray", alpha = 0.8) +  # Default gray for all communities
tm_shape(highest_crime_community) + 
  tm_polygons(col = "red", alpha = 0.8) +  # Highlight highest crime in red
  tm_text(text = "community", size = 0.5, col = "black") +  # Add label
tm_shape(lowest_crime_community) + 
  tm_polygons(col = "green", alpha = 0.8) +  # Highlight lowest crime in green
  tm_text(text = "community", size = 0.5, col = "black") +  # Add label
tm_layout(main.title = "Higest and Lowest Amount of Crime", # Add a title
          main.title.position = "center",
          main.title.size = 1,
          frame = FALSE)


###Part 2
##Step 1
setwd("/Users/taceharris/Desktop/QMSS 301/Project 1")
##Load in Packages
library(sf)
library (tmap)
library(dplyr)

#Load in Necessary Data
school_location <- st_read('schools.shp')
crime_data <- read.csv('crimes1.csv')
community_areas <- st_read ("communities.shp")

#Check if school_location is projected and make it projected if it is not
st_is_longlat(school_location) #It is not projected
school_location_pj <- st_transform(school_location,crs = 3435) #Make projected
st_is_longlat(school_location_pj) #Now it is projected

#Make Crime Data a Shape File
colnames(crime_data) #Check where long/lat is stored and by what name
crime_data_longlat <- st_as_sf(crime_data, coords= c('Longitude', 'Latitude'))
st_crs(crime_data_longlat) <- 4326 

#Make Crime Data Projected
crime_data_pj <- st_transform(crime_data_longlat, crs = 3435)

#Filter only criminal damage done to property
crime_filtered <- crime_data_pj %>%
  filter(Primary.Type == "CRIMINAL DAMAGE" & Description == "TO PROPERTY")

# Create a buffer of 0.5 mile radius around each school
school_half_buff <- st_buffer(school_location_pj, dist = 2640)
school_half_buff

# Create another buffer of 1 mile around the schools and call it 'school_1m_buff'.
school_1m_buff <- st_buffer(school_location_pj, dist = 5280)
school_1m_buff

# Check which crimes fall within the 0.5-mile buffer
crimes_in_half_mile <- st_within(crime_filtered, school_half_buff, sparse = FALSE)
property_crime_count_half_mile <- apply(crimes_in_half_mile, MARGIN = 2, FUN = sum)

# Check which crimes fall within the 1-mile buffer
crimes_in_one_mile <- st_within(crime_filtered, school_1m_buff, sparse = FALSE)
property_crime_count_one_mile <- apply(crimes_in_one_mile, MARGIN = 2, FUN = sum)

#Bind counts back to school location
school_location_pj <- cbind(school_location_pj, property_crime_count_half_mile, property_crime_count_one_mile)

# View results
print(school_location_pj)

#Make sure community areas are projected
community_areas_pj <- st_transform(community_areas, crs = 3435)
st_is_longlat(community_areas_pj) #Check it worked, and it said FALSE so it did

# First Map: School Locations + Community Borders
tmap_mode("plot") # For ploting view

map_schools <- tm_shape(community_areas_pj) + 
  tm_borders(col = "gray", lwd = 1.5, alpha = 0.7) +  # Add community borders
  tm_shape(school_location_pj) + 
  tm_dots(col = "blue", size = 0.1, title = "Schools") +
  tm_layout(title = "School Locations with Community Borders")

# Display First Map
print(map_schools)

# Second Map: Schools, Buffers, and Crime Incidents 
map_schools_crime_half_mile <- tm_shape(community_areas_pj) + 
  tm_borders(col = "gray", lwd = 1.5, alpha = 0.7) +  # Community borders
  tm_shape(school_half_buff) + 
  tm_borders(col = "red", lwd = 2, alpha = 0.3) +  # Half-mile buffer zones with lower opacity
  tm_shape(school_location_pj) + 
  tm_dots(col = "blue", size = 0.05, title = "Schools", alpha = 0.7) +  # Smaller school dots
  tm_shape(crime_filtered) + 
  tm_dots(col = "black", size = 0.02, title = "Criminal Damage to Property", alpha = 0.5) +  # Smaller and more transparent crime dots
  tm_layout(title = "Crimes Within 0.5 Miles")

# Display the updated map with only crimes within the 0.5-mile buffer
print(map_schools_crime_half_mile)

##Step 2
#Prepare for Tableau
#Sort Schools by Crime
school_sorted_by_crime <- school_location_pj %>%
  arrange(desc(property_crime_count_one_mile))
#Select Top 10 Schools, with the most crime in a 1mile radius
top_10_schools <- head(school_sorted_by_crime, 10)

#Select Bottom 10 Schools, with the least crime in a 1 mile radius
bottom_10_schools <- tail(school_sorted_by_crime, 10)

#Save CSVs for Tableau
write.csv(top_10_schools, file = "/Users/taceharris/Desktop/top_10_schools_crime_1m.csv", row.names = FALSE)
write.csv(bottom_10_schools, file = "/Users/taceharris/Desktop/bottom_10_schools_crime_1m.csv", row.names = FALSE)

#Summary Statistics for Findings & Conclusions
summary (community_areas_pj)

summary (zip_codes_pj)

summary (school_location_pj)
