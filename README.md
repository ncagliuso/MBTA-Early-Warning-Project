# MBTA-Early-Warning-Metrics

## Purpose

The purpose of this project is to categorize all of the requisitions featured in the weekly Early Warning report, so as to make metrics based on each of the categories/help Ray prioritize certain requisitions for his weekly meeting in which he uses the Early Warning Report.

### Package Requirements

#### Software Packages 

* `R 3.5.1`

##### R Packages

* `dplyr` for data manipulation 
* `lubridate` for date handling
* `tidyverse` for data tidying
* `openxlsx` for reading files from Excel

### Data Requirements

This project takes 1 excel file with 2 separate sheets as input:

#### `Early Warning Project.xlsx` `sheet = Without PO` `sheet = With PO`

This excel file should contain the following columns, identical on each sheet:

| Columns                      | Purpose/Use                               |
| ---------------------------- | ----------------------------------------- |
| Executing_Department         | Not used                                  |
| Project_ID                   | Unique Identifier for MBTA Project        |
| Project_Name                 | Self-explanatory                          |
| Director                     | Project Director                          |
| Project_Manager              | Self-explanatory                          |
| WO_No                        | Work Order Number                         |
| Req_ID                       | Unique identifier for each requisition    |
| Req_Created_Date             | Self-explanatory                          |
| Req_Approval_Date            | Self-explanatory                          |
| PO_No.                       | Unique Identifier of Purchase Order       |
| PO_Created_Date              | Self-explanatory                          |
| PO_Approval_Date             | Self-explanatory                          |
| Req_Descr                    | Description of requisition                |
| Buyer_Line                   | Buyer assigned to the req at line level   |
| Unit                         | Business Unit of requisition              |
| Hold_Status                  | Self-explanatory                          |
| Out-to-bid                   | Whether req is Out to Bid; can be Y or N  |
| Status                       | Requisition Status                        |
| Buyer_Header                 | Buyer assigned to req at header level     |
| Next_Steps                   | Comment field for Ray                     |
| Duration                     | Number of days since Req_Approval_Date    |

### Output file(s)

This project creates four dataframes divided by type of Requisiton/PO which, when compiled, add up to the original Early Warning report. They are "In," "Out," "In Queue," and "Actionable." Explanations of these four terms can be found within the comments in the R script.
