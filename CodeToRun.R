#install.packages('text2vec')
#install.packages('mlapi')
#install.packages('text2vec')

#options(java.parameters = c("-Xmx128g"))
#devtools::install_github("parkdongsu/noteCovariateExtraction",ref = 'develop',auth_token = '439f56a4fd8d635a3f542528cb0a30e6f7945c9e')
library(noteCovariateExtraction)
library(RehospitalizationPredictionWithNote)
# USER INPUTS
#=======================
# Specify where the temporary files (used by the ff package) will be created:
options(fftempdir = "D:/git/temp")#dir

# The folder where the study intermediate and result files will be written:
outputFolder <- "D:/git/output"#dir

# Details for connecting to the server:
dbms <- "sql server"
user <- ''#id
pw <- ''#passwod
server <- '128.1.99.58'
port <- '1433'
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw,
                                                                port = port)
connection <- DatabaseConnector::connect(connectionDetails)
# Add the database containing the OMOP CDM data
cdmDatabaseSchema <- 'Dolphin_CDM.dbo'
# Add a database with read/write access as this is where the cohorts will be generated
cohortDatabaseSchema <- 'Dolphin_CDM.dbo'

oracleTempSchema <- NULL

# table name where the cohorts will be generated
cohortTable <- 'RehospitalizationPredictionWithNoteCohort'
#=======================

execute(connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        outputFolder = outputFolder,
        createProtocol = F,
        createCohorts = F,
        runAnalyses = T,
        createResultsDoc = F,
        packageResults = T,
        createValidationPackage = T,
        minCellCount= 5)