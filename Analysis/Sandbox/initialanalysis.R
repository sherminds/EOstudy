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
odata <- read.csv("AllData_20160718.csv", stringsAsFactors = FALSE)
dim(odata)
adata <- odata[odata$Include == TRUE,]
dim(adata)
adata <- cbind(adata, rInv = adata$Invited_W / adata$Invited_nb, rIns = adata$Instructor_W / adata$Instructor_nb, rOrg = as.numeric(adata$Org_W) / as.numeric(adata$Org_nb))

plot(adata$rOrg, adata$rInv, xlim = c(0, 1), ylim = c(0, 1), xlab = "Prop. W among organisers", ylab = "Prop. W among invited speakers", las = 1)
aOI  <- lm(rInv~rOrg, data=adata)
abline(aOI)

# Those who replied
aa <- adata[!is.na(adata$Org_reply1), ]
# Check consistency when merging data
all(aa$Ad_ID == aa$Event.name)

# Check lines where people corrected the result
checkno <- aa[aa$Question.0=="No",]

compcols.oneline <- function(a, b){
  if(is.na(a) & is.na(b)) return(TRUE)
  else
    if( (is.na(a) & !is.na(b)) | (!is.na(a) & is.na(b)) ) return(FALSE)
    else
      if(a==b) return(TRUE) else return(FALSE)
}
compcols <- function(A, B){
  n <- length(A)
  out <- rep(0, n)
  for (i in 1:n){
    out[i] <- compcols.oneline(A[i], B[i])
  }
  return(out)
}

tmp <- aa[, c(1, 32, 12, 33, 13, 34, 14, 35, 15, 36, 16, 37, 17, 38, 18, 39, 19, 40)]
diffcols <- !( compcols(tmp[,3], tmp[,4]) & compcols(tmp[,5], tmp[,6]) & compcols(tmp[,7], tmp[,8]) & compcols(tmp[,9], tmp[,10]) & compcols(tmp[,11], tmp[,12]) & compcols(tmp[,13], tmp[,14]) & compcols(tmp[,15], tmp[,16]) & compcols(tmp[,17], tmp[,18]))

tmp[diffcols & tmp$Question.0=="Yes",]

# Effect of proportion of female speakers on whether organizers replied
tmp.reply <- !is.na(adata$Org_reply1)
boxplot(adata$rInv ~ tmp.reply, main="Replied?")

adata[is.na(adata$Org_reply1),]

adata$Org_name1[duplicated(adata$Org_name1)]

