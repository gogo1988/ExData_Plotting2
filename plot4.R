# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#

if (!file.exists("./uncompressedFiles")){
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL,"./exdata-data-NEI_data.zip")
        
        zipFile<-list.files("./",".zip")
        
        unzip(zipFile,exdir='./uncompressedFiles/')
        
        NEI <- readRDS("./uncompressedFiles/summarySCC_PM25.rds")
        SCC <- readRDS("./uncompressedFiles/Source_Classification_Code.rds")
}


library(dplyr)
coalData<-filter(SCC,grepl('Coal',EI.Sector,ignore.case=TRUE)|grepl('Coal',EI.Sector,ignore.case=TRUE))
coalData <- NEI[NEI$SCC %in% coalData$SCC, ]
coalTotalEmissions<-aggregate(coalData$Emissions,by=list(coalData$year),FUN=sum)

png(filename = "./plot4.png")

plot(coalTotalEmissions$Group.1,coalTotalEmissions$x/10^6,
     type='l',
     main='Total emissions from from Coal \n in the US from 1999 to 2008',
     xlab='Year',
     ylab = (expression("Total PM"[2.5]*" Emissions (million tonnes)")))

dev.off()