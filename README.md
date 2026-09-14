# Sql-Data-Cleaning-Nashville-Housing
# Data Cleaning with SQL: Nashville Housing Dataset

# Data Cleaning with SQL: Nashville Housing Dataset

## Overview
A SQL-based data cleaning project using the Nashville Housing dataset. The raw data had 
inconsistent date formats, missing property addresses, combined address fields, and 
inconsistent Yes/No values — this project cleans and standardises it into an analysis-ready 
table using T-SQL.

## Dataset
- Source: [https://data.nashville.gov/search?categories=%252Fcategories%252Fbusiness%2C%252Fcategories%252Fbusiness%252C%2520development%2520and%2520housing]
- Description: property sale records including parcel ID, address, sale price, sale date, 
  legal reference, and owner information
- File: `Nashville Housing Data for Data Cleaning.xlsx

## Tools Used
- SQL Server / SSMS (T-SQL)

## Data Cleaning Steps
- Standardised inconsistent `SaleDate` formatting into a proper `Date` type
- Populated missing `PropertyAddress` values by matching records on `ParcelID`
- Split combined `PropertyAddress` and `OwnerAddress` fields into separate Address, 
  City, and State columns using `SUBSTRING` and `PARSENAME`
- Standardised `SoldAsVacant` field values from inconsistent `Y`/`N` entries to `Yes`/`No`
- Identified and flagged duplicate records using `ROW_NUMBER()` with `PARTITION BY`
- Removed unused/redundant columns after extracting the data needed from them

## SQL Techniques Used
- `ALTER TABLE` / `UPDATE` to add and populate new columns
- `SELF JOIN` to fill in missing address data from matching parcel records
- `SUBSTRING()` and `PARSENAME()` for parsing and splitting address strings
- `CASE WHEN` for standardising categorical values
- `ROW_NUMBER() OVER (PARTITION BY ...)` (window function) to detect duplicate rows
- `ALTER TABLE ...
