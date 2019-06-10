#Early Warning Project
#Nick Cagliuso
#This project takes the weekly Early Warning Report and slices it into different dataframes based on specific 
#definitions of reqs/POs that Ray would like to be highlighted/singled out

library(tidyverse)
library(dplyr)
library(openxlsx)
library(lubridate)
setwd("C:/Users/NCAGLIUSO/Desktop/Early Warning")
With_PO<- read.xlsx("Early Warning Project.xlsx", sheet = "With PO")
Without_PO <- read.xlsx("Early Warning Project.xlsx", sheet = "Without PO")
Without_PO <- Approved_Open[-c(119:123), ]
#Remove WO#'s not featured in both queries used to make report; currently manual but should be function/if statement

Early_Warning <- rbind(With_PO,Without_PO)
Early_Warning$Req_Created_Date <- as.Date.numeric(Early_Warning$Req_Created_Date, origin = "1899-12-30")
#Dates are off by two days when brought into R for unknown reason, so origin date is manually adjusted

Early_Warning$Req_Approval_Date <- as.Date.character(Early_Warning$Req_Approval_Date, format = "%m/%d/%Y", 
                                                     origin = "1899-12-30")
Early_Warning$PO_Created_Date <- as.Date.character(Early_Warning$PO_Created_Date, format = "%m/%d/%Y", 
                                                   origin = "1899-12-30")
Early_Warning$PO_Approval_Date <- as.Date.character(Early_Warning$PO_Approval_Date, format = "%m/%d/%Y", 
                                                    origin = "1899-12-30")

EW_Appended <- Early_Warning
EW_Appended$Duration <- NULL
EW_Appended <- EW_Appended %>% mutate(Req_Created_Duration = today() - .data$Req_Created_Date)
EW_Appended <- EW_Appended %>% mutate(Req_Approved_Duration = today() - .data$Req_Approval_Date)
EW_Appended <- EW_Appended %>% mutate(PO_Created_Duration = today() - .data$PO_Created_Date)
EW_Appended <- EW_Appended %>% mutate(PO_Created_Duration = today() - .data$PO_Approval_Date)
EW_Appended <- EW_Appended %>% mutate(Spin_Time = .data$PO_Created_Duration - .data$Req_Approved_Duration)
In <- EW_Appended %>% filter(.data$Req_Created_Duration < 7)
#"In" = Newly created reqs that joined the report this week

Out <- EW_Appended %>% filter(.data$Req_Approved_Duration <7)
#"Out" = Newly approved reqs that should become PO's in the relatively near future
 
In_Queue <- EW_Appended %>% filter(.data$Status != "C" & .data$PO_No. != "NA")
#"In Queue" = Incomplete reqs that have not yet become PO's; these take priority in Ray's eyes

Actionable <- In_Queue %>% filter(.data$Hold_Status == "No Hold" & .data$`Out-to-bid` == "N")
#"Actionable" = POs that can be worked on since they are neither on hold nor out to bid; also important to Ray
