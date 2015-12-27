# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?


if (!file.exists("./uncompressedFiles")){
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL,"./exdata-data-NEI_data.zip")
        
        zipFile<-list.files("./",".zip")
        
        unzip(zipFile,exdir='./uncompressedFiles/')
        
        NEI <- readRDS("./uncompressedFiles/summarySCC_PM25.rds")
        SCC <- readRDS("./uncompressedFiles/Source_Classification_Code.rds")
}

library(dplyr)
library(ggplot2)

motorData <- filter(SCC, grepl("On-Road", EI.Sector))
motorData2<- filter(SCC, grepl("motor", Short.Name, ignore.case=TRUE))
nei24510_06037<-NEI[which(NEI$fips=="24510"|NEI$fips=="06037"),]

motorDataSubset<-nei24510_06037[nei24510_06037$SCC %in% motorData$SCC, ]

png(filename = "./plot6.png")

g<-ggplot(motorDataSubset, aes(x=year,y=Emissions, color=fips)) +
        stat_summary(geom="line", fun.y="sum")+
        labs(x="year",
             y = (expression("Total PM"[2.5]*" Emissions")),
             title="Comparison of total emissions in \n Baltimore City and Los Angeles County \n from 1999 to 2008") +
        scale_colour_discrete(name = "Group", label = c("Los Angeles","Baltimore"))

print(g)

dev.off()