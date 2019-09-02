
### An Approach to optimize manual testing bcuket with Apriori
# R Studio Version 1.1.45




# Install the required package (Ignore if already installed)
install.packages("arules")

# Loading the package
library(arules)

# reading the data from the directory
data <- read.csv("testing_results.csv", sep = ",")
View(data)

# Removing the non required columns
data <- data[-(1:3)]
data <- unname(data)

# Saving the file in trasactions format
write.csv(data,'tc_data_txnFormat.csv',row.names = FALSE)
tc_data <- read.transactions("tc_data_txnFormat.csv", sep = "," )

# inspecting data
inspect(tc_data[1:3])

# Checking Summary of raw data
summary(tc_data)



# Plot the 10 most frequent failed test cases
itemFrequencyPlot(tc_data, topN = 10)

# Plot a Matrix diagram forvfirst 150 rows
image(sample(tc_data, 150))



# Training Model using arules packages 
tc_association = apriori(tc_data, parameter = list(support =0.005, confidence = 0.25,minlen = 2))
tc_association

# Summary of rules 
summary(tc_association)

# Inspecting the first 3 rules 
inspect(tc_association[1:3])

# Sorting the rules as per lift value
View(inspect(sort(tc_association, by = "lift")))

# Inspecting the first 5 rules having highest lift 
inspect(sort(tc_association, by = "lift")[1:5])



# Checkingassociation rules for specific test cases to find assocations

rule <- subset(tc_association, items %in% "TC-PCK_32079" )
tc.lhs.rule <- subset(rule,  lhs %in% "TC-PCK_32079" )
inspect(sort(tc.lhs.rule,by="lift"))


# Saving the rules in csv file
write(tc_association, file = "Test_Cases_assocation_rules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)


