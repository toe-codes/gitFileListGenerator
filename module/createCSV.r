# Define the library
library("dplyr")

# Read Argument
path.script = commandArgs(trailingOnly=TRUE)[1]
path.numstat = commandArgs(trailingOnly=TRUE)[2]
path.nameStatus = commandArgs(trailingOnly=TRUE)[3]
path.lsFiles = commandArgs(trailingOnly=TRUE)[4]

# Read files
df.numstat <- read.table(path.numstat)
df.nameStatus <- read.table(path.nameStatus)
df.lsFiles <- read.table(path.lsFiles)

# Bind numstat and nameStatus
df.result <- cbind(df.numstat, df.nameStatus)

# Delete the dupulicate columns
df.result <- df.result[, c(3,4,1,2)]

# Name columns
colnames(df.result) <- c("path", "status", "insertion", "deletion")
colnames(df.lsFiles) <- c("path")

# Rename values
df.result$status <- sub("M", "Modify", df.result$status)
df.result$status <- sub("A", "Add", df.result$status)
df.result$status <- sub("C", "Copy", df.result$status)
df.result$status <- sub("R", "Rename", df.result$status)
df.result$status <- sub("D", "Delete", df.result$status)

# Change type
df.result$path <- as.character(df.result$path)
df.lsFiles$path <- as.character(df.lsFiles$path)

# Join dataframes
df.resultAll <- left_join(df.lsFiles,df.result,by="path")

# Change NA to blank
df.result[is.na(df.result)] <- ""
df.resultAll[is.na(df.resultAll)] <- ""

# Save as CSV
write.csv(df.result, paste(path.script, "/result/result.csv", sep = ""))
write.csv(df.resultAll, paste(path.script, "/result/resultAll.csv", sep = ""))
