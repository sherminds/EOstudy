# Clean the memory
rm(list=ls())

# Load the answers
tbl <- read.csv("Responses_20160717.csv", stringsAsFactors = FALSE)

# Create columns with ratios
tbl <- cbind(tbl, rInv = tbl$New_Invited_W / tbl$New_Invited_nb, #
             rIns = tbl$New_Instructor_W / tbl$New_Instructor_nb, #
             rOrg = tbl$New_Org_W / tbl$New_Org_nb)

# Plots
# Questions
boxplot(rInv ~ Question.1, data = tbl, main="Q1: Aware?")
boxplot(rInv ~ Question.2, data = tbl, main="Q2: Took gender into account?")
boxplot(rInv ~ Question.3, data = tbl, main="Q3: Prescriptions?")
# Organisers
plot(tbl$rOrg, tbl$rInv, xlim = c(0, 1), ylim = c(0, 1))
summary(lm(rInv~rOrg, data = tbl))

# All data
## NOTE: THIS IS EXTREMELY COARSE, NEED TO DISTINGUISH BETWEEN TYPES OF EVENTS
odata <- read.csv("tmpdata.csv", stringsAsFactors = FALSE)
dim(odata)
adata <- odata[odata$Include == TRUE,]
dim(adata)
adata <- cbind(adata, rInv = adata$Invited_W / adata$Invited_nb, rIns = adata$Instructor_W / adata$Instructor_nb, rOrg = as.numeric(adata$Org_W) / as.numeric(adata$Org_nb))

plot(adata$rOrg, adata$rInv, xlim = c(0, 1), ylim = c(0, 1), xlab = "Prop. W among organisers", ylab = "Prop. W among invited speakers", las = 1)
aOI  <- lm(rInv~rOrg, data=adata)
abline(aOI)






