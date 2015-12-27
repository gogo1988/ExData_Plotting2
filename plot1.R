# Questions
# 
# You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
# 
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#
# download files
if (!file.exists("./uncompressedFiles")){
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL,"./exdata-data-NEI_data.zip")
        
        zipFile<-list.files("./",".zip")
        
        unzip(zipFile,exdir='./uncompressedFiles/')
        
        NEI <- readRDS("./uncompressedFiles/summarySCC_PM25.rds")
        SCC <- readRDS("./uncompressedFiles/Source_Classification_Code.rds")
}

totalEmissions<-aggregate(NEI$Emissions,by=list(NEI$year),FUN=sum)

png(filename = "./plot1.png")


plot(totalEmissions$Group.1,totalEmissions$x/10^6,
     type='l',
     main='Total emissions from PM2.5 decreased in \n the United States from 1999 to 2008',
     xlab='Year',
     ylab = (expression("Total PM"[2.5]*" Emissions (million tonnes)")))

dev.off()



#
#
#


#
#

