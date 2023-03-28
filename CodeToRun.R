# Install dependencies -----
#install.packages("renv") # if not already installed, install renv from CRAN
renv::restore() # this should prompt you to install the various packages required for the study

# Load packages ------
library(CirceR)
library(CDMConnector)
library(here)
library(DBI)
library(dplyr)
library(readr)
library(log4r)

# database metadata and connection details -----
# The name/ acronym for the database
databaseName<-"...."

# Database connection details -----
# In this study we also use the DBI package to connect to the database
# set up the dbConnect details below (see https://dbi.r-dbi.org/articles/dbi for more details)
# you may need to install another package for this 
# (although RPostgres is included with renv in case you are using postgres or redshift)
# eg for postgres 
# db <- dbConnect(RPostgres::Postgres(), dbname = server_dbi, 
#                 port = port, host = host, user = user,
#                 password = password)
db <- dbConnect("....")

# The name of the schema that contains the OMOP CDM with patient-level data
cdm_database_schema<-"...."

# The name of the schema where results tables will be created 
results_database_schema<-"...."

# Name of table prefix to use in the result schema for tables created during 
# the study
# Note, if there is an existing table in your results schema with the same name
# it will be overwritten 
# Also note, this must be lower case
table_prefix <- "...."

# create cdm reference ----
cdm <- cdmFromCon(con = db,
                  cdmSchema = cdm_database_schema,
                  writeSchema = results_database_schema,
                  cdmName = databaseName)
# check database connection
# running the next line should give you a count of your person table
cdm$person %>% 
  tally()

# Run the study ------
source(here("RunStudy.R"))
# after the study is run you should have a zip folder in your output folder to share

cat(paste0("Thanks for running the study you can find the results (feasibility_count_", databaseName, ".csv) in: ", here("Results"))
