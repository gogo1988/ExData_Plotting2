# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# 
if (!file.exists("./uncompressedFiles")){
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL,"./exdata-data-NEI_data.zip")
        
        zipFile<-list.files("./",".zip")
        
        unzip(zipFile,exdir='./uncompressedFiles/')
        
        NEI <- readRDS("./uncompressedFiles/summarySCC_PM25.rds")
        SCC <- readRDS("./uncompressedFiles/Source_Classification_Code.rds")
}

nei24510<-NEI[which(NEI$fips=="24510"),]
totalEmissions<-aggregate(nei24510$Emissions,by=list(nei24510$year),FUN=sum)

png(filename = "./plot2.png")

plot(totalEmissions$Group.1,totalEmissions$x/10^6,
     type='l',
     main='Total emissions from PM2.5 decreased in \n Baltimore City from 1999 to 2008',
     xlab='Year',
     ylab = (expression("Total PM"[2.5]*" Emissions (million tonnes)")))

dev.off()
