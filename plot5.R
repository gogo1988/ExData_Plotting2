# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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
motorData <- filter(SCC, grepl("On-Road", EI.Sector))
nei24510<-NEI[which(NEI$fips=="24510"),]

motorDataSubset<-nei24510[nei24510$SCC %in% motorData$SCC, ]
motorTotalEmissions<-aggregate(motorDataSubset$Emissions,by=list(motorDataSubset$year),FUN=sum)

png(filename = "./plot5.png")

plot(motorTotalEmissions$Group.1,motorTotalEmissions$x/10^6,
     type='l',
     main='Total emissions from from vehicles  \n in Baltimore City',
     xlab='Year',
     ylab = (expression("Total PM"[2.5]*" Emissions (million tonnes)")))

dev.off()
