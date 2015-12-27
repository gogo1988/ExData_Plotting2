# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# 
#
if (!file.exists("./uncompressedFiles")){
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL,"./exdata-data-NEI_data.zip")
        
        zipFile<-list.files("./",".zip")
        
        unzip(zipFile,exdir='./uncompressedFiles/')
        
        NEI <- readRDS("./uncompressedFiles/summarySCC_PM25.rds")
        SCC <- readRDS("./uncompressedFiles/Source_Classification_Code.rds")
}
#
libary(ggplot2)
nei24510<-NEI[which(NEI$fips=="24510"),]
totalEmissions<-aggregate(nei24510$Emissions,by=list(nei24510$year),FUN=sum)


png(filename = "./plot3.png")
g<-ggplot(nei24510, aes(x=year,y=Emissions, color=type)) +
        stat_summary(geom="line", fun.y="sum")+
        labs(x="year",
             y = (expression("Total PM"[2.5]*" Emissions")),
             title="Total emissions in Baltimore City from 1999 to 2008")

print(g)

dev.off()