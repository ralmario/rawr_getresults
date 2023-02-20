# Version 1.0.0
# This is a personal project of mine where it populates a list of game names and
# extracts the year when the game is first released, this is to automate my 
# game database to add details based on the game name

# Check if package is installed, if not, install it
# List of packages to be installed and loaded
pkg <- c("jsonlite", "openxlsx", "dplyr")

# Check if packages are installed, if not, install them
for (p in pkg) {
   if (!require(p, character.only = TRUE)) {
      install.packages(p)
      library(p, character.only = TRUE)
   } else {
      library(p, character.only = TRUE)
   }
}

# Define a function that takes in a input spreadsheet name (s) and output spreadsheet name (t)
getResults <- function(s,t) {
   
   # Create a filename for the spreadsheet
   spreadsheet <- paste0(s, ".xlsx")
   
   # Read the first sheet of the Excel file into a data frame
   games <- read.xlsx(spreadsheet, sheet = 1, colNames = TRUE, 
                          skipEmptyRows = TRUE, skipEmptyCols = TRUE, 
                          fillMergedCells = FALSE, startRow = 1)
   
   # Create an empty vector to store the years
   years <- vector(length = nrow(games))

   # Loop through each row of the data frame
   for (row in 1:nrow(games)) {
      
      # Get the game name from the "Game.Name" column of the current row
      game_name <- games[row, "Game.Name"]
      
      # Format the game name for use in a URL by replacing spaces with "+" signs
      game_name_url <- gsub(" ", "+", trimws(game_name))
      
      # Build a URL for the Rawg API with the formatted game name and an API key
      rawr_api <- paste0("https://api.rawg.io/api/games?key=KEYHERE&search=", 
                        game_name_url)
      
      # Call the Rawg API and convert the resulting JSON to a data frame
      game_details <- fromJSON(rawr_api)
      game_details_table <- game_details[["results"]] %>% as.data.frame 
      
      # Get the year when the game is released
      year <- substr(game_details_table[1, "released"], 1 ,4)
      
      # Store the details when the year it was released in the vector of years
      years[row] <- year
      
      # Pause for 1 second before making the next API call to avoid overloading the server
      Sys.sleep(1)
   }
   
   # Add a new column to the `games` data frame with the year released
   games$Year.Released <- years
   
   # Create a filename for the output Excel file
   spreadsheet <- paste0(t, ".xlsx")
   
   # Write the updated `games` data frame to an Excel file
   write.xlsx(games, spreadsheet, sheetName="Sheet1", 
              col.names=TRUE, row.names=FALSE, append=FALSE, showNA=FALSE)
   
}

