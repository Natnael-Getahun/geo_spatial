####################################
#     Practical Lab demo
####################################
# Cleaning the workspace 
    rm(list=ls()) # To remove all list
    rm(a,b)       # To remove a and b
    ls()          # To see the list of objects
    
    #################################################
    # Part 1:  Spatial data Management
    #################################################    
    
# Loading Library
  library(sf);library(terra);library(spdep);
  library(ggplot2);library(mapview);library(rnaturalearth)
    
# Loading Ethiopia shapefile and Explore it
    #1. Load and explore Ethiopia shape file data
    ETH.region=st_read("Data/Shapefiles/ETH2021/eth_admbnda_adm1_csa_bofedb_2021.shp") #
    class(ETH.region)
    plot(ETH.region$geometry)
    # Get CRS
    st_crs(ETH.region)
    # Zone level data
      ETH.Zone=st_read("Data/Shapefiles/ETH2021/eth_admbnda_adm2_csa_bofedb_2021.shp") #
      plot(ETH.Zone$geometry)
  #2. Extract ONLY part of the shapefile (i.e. Map South-west Ethiopia
    Tigray=ETH.region$ADM1_EN=="Tigray"
    library(dplyr)
    SWETH <- ETH.region %>% filter(ADM1_PCODE =="ET11")
    plot(SWETH$geometry)
  #3. Add tabular data with the shapefile
    mcp_data=read.csv("Data/mCP2019.csv")
    ETH.Zone$mcp=c(mcp_data$mcp)
    ETH.Zone$mean_dist=c(mcp_data$mean)
    ETHzone_mcp=ETH.Zone[,c(1,2,3,8,15,16,17)]
    View(ETHzone_mcp)
    
  #4. Raster data management(library(terra) )
    ## Load population density raster file
    library(terra)
    access=terra::rast("Data/ShapeFiles/raster/eth_pop_2015.tif")
    plot(access)
    r_eth <- rast(access)
    # Get CRS
    crs(r_eth)
    # Transform CRS
    r2 <- terra::project(r_eth, "EPSG:32636")
    # Get CRS
    crs(r2)
    
    #Example 2: Elivation data
    pathraster <- system.file("ex/elev.tif", package = "terra")
    r <- terra::rast(pathraster)
    r  # to get basic info about the raster object
    plot(r)
    class(r)
    
   #5. Get data from online sources (https://data.humdata.org/)
      # Load your prefered spatial data and explore it
    
    
   #6. Creating Spatial data
    library(sp)
    vec <- vector(mode = "numeric", length = 5)
    df <- data.frame(x = 1:5, y = c(0.5, 1.5, 3, 4.6,6.4))
    mat <- as.matrix(df) # create matrix object with as.matrix
    sp1 <- SpatialPoints(coords = mat)
    class(sp1)
    # Extend the pre-existing object sp1 by adding data from df.
    spdf <- SpatialPointsDataFrame(sp1, data = df)
    class(spdf)
    
   #7. Spatial data transformation
      # Convert UTM to lat/lon or vise-versa
      # use st_transform
    
  #################################################
  # Part 2: Data visualization
  #################################################  
    library(rnaturalearth);library(sf); library(ggplot2); library(viridis)
    map <- ne_countries(continent = "africa")
    plot(map$geometry)
    # Loading the data and merging with the shapefile
    d=read.csv("Data/Africa_Nutrition.csv")
    map$underweight=d$Under.weight
    map$Normal=d$Normal.Weight
    map$Overweight=d$Over.weight
    map$Obese=d$Obese
    # Mapping malnutirion by country
    ggplot(data=map,aes(fill=Obese)) + geom_sf() +scale_fill_viridis() + theme_bw()
    ggsave("Obese.pdf")
    ggsave("Obese.png",width=6,height=9,dpi="screen")
    
  #################################################
  # Part 3: Spatial Weighting matrix construction
  #################################################
    #3.1 Spatial weight
    
    #3.2 Spatial autocorrelation
    
  #################################################
  # Part 4: Spatial Autoregressive Data Modeling
  #################################################
    
    