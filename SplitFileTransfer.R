setwd("~/../Desktop/SPlit/DoWork/")
Read_File <- "Test.jpg"
Final_File <- "Result.jpg"
file_info <- file.info(Read_File)
x <- file(Read_File, 'rb')
#Read <- readBin(x, raw(), size = 1, endian = 'little', n = file_info$size)

Split_size <- 100000
Divisions <- floor(file_info$size/Split_size)
Extra <- file_info$size%%Split_size
for(each in 1:Divisions){
  Read <- readBin(x, raw(), size = 1, endian = 'little', n = Split_size)
  if(!(paste("File_Split&&", each, ".SF", sep = "") %in% dir())){
    file.create(paste("File_Split&&", each, ".SF", sep = ""))
  } else {
    file.remove(paste("File_Split&&", each, ".SF", sep = ""))
    file.create(paste("File_Split&&", each, ".SF", sep = ""))
  }
  connection <- file(paste("File_Split&&", each, ".SF", sep = ""), 'wb')
  writeBin(Read, connection)
  close(connection)
  print(paste(each, "of", Divisions+1))
}
Read <- readBin(x, raw(), size = 1, endian = 'little', n = Extra)
if(!(paste("File_Split&&", Divisions+1, ".SF", sep = "") %in% dir())){
  file.create(paste("File_Split&&", Divisions+1, ".SF", sep = ""))
} else {
  file.remove(paste("File_Split&&", Divisions+1, ".SF", sep = ""))
  file.create(paste("File_Split&&", Divisions+1, ".SF", sep = ""))
}
connnection <- file(paste("File_Split&&", Divisions+1, ".SF", sep = ""), 'wb')
writeBin(Read, connection)
close(connection)
print("Done")

Broken_Files <- unique(gsub("&&.*$", "", dir()[grepl(".SF", dir())]))
for(each in Broken_Files){
  Files <- dir()[grepl(pattern = paste(each), x = dir())]
  Count <- length(dir()[grepl(pattern = paste(each), x = dir())])
  Big_Message <- c()
  Small_Message <- c()
  for(part in 1:Count){
    FILE <- paste(each, "&&", part, ".SF", sep = "")
    print(paste("Appending", FILE,  "part", part, "of", Count, "for", each))
    Part <- file(Files[part], 'rb')
    partInfo <- file.info(Files[part])
    Read <- readBin(Part, raw(), size = 1, endian = 'little', n = partInfo$size)
    Small_Message <- c(Small_Message, Read)
    close(Part)
    if(length(Small_Message) > round(sqrt(Count)*partInfo$size)){
      Big_Message <- c(Big_Message, Small_Message)
      Small_Message <- c()
      print("Resized")
    }
  }
  Big_Message <- c(Big_Message, Small_Message)
}
if(!(Final_File %in% dir())){
  file.create(Final_File)
} else {
  file.remove(Final_File)
  file.create(Final_File)
}
connection <- file(Final_File, 'wb')
writeBin(Big_Message, connection)
close(connection)
closeAllConnections()

#convert_to_binary <- function(n) {
#  if(n > 1) {
#    convert_to_binary(as.integer(n/2))
#  }
#  cat(n %% 2)
#}
#convert_to_binary(3)

