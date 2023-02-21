
# Access Rawg.io API to Complete Details of an Excel File

## Overview
**Version 1.0.0**

This code is designed to take a spreadsheet containing a list of video game titles and use the Rawg API to retrieve the when the games are released. The resulting years are then written to a new spreadsheet. Based on a personal project of mine.

## Dependencies

This code requires the following R packages:
- `openxlsx`
- `jsonlite`
- `dplyr`
## Input

The code requires the following input parameters:

- `s`: a string representing the name of the input spreadsheet (must be in .xlsx format).
- `t`: a string representing the name of the output spreadsheet (will also be in .xlsx format).
## Output

The code produces a spreadsheet containing the year released of the video games listed.

## Usage

1. Save the input spreadsheet in **.xlsx** format. Make sure the name of the column of the game name is *Game Name*
2. In RStudio or the R console, set the working directory to the location of the input spreadsheet.
3. Call the getResults() function with the appropriate parameters: `getResults(s = "input_spreadsheet_name", t = "output_spreadsheet_name")`
4. The resulting spreadsheet will be saved in the working directory.


## Authors

- [Ranxel Almario](https://www.github.com/ralmario)