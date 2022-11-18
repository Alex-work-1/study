library(data.table)
library(ggplot2)


# path to folder where folder named data is located

# setwd("")

# import data tables
fls <- list.files(path = "./data/",
                  pattern = ".csv",
                  full.names = TRUE)
fls
dta_app <- lapply(X = fls[grep(pattern = "prih",
                               x = fls)],
                  FUN = fread)
dta_app <- rbindlist(l = dta_app)
dta_app


dta_adm <- lapply(X = fls[grep(pattern = "zaj",
                               x = fls)],
                  FUN = fread)
dta_adm <- rbindlist(l = dta_adm)
dta_adm




#how many admited

admited <- (dta_app[`Rozh. o přijetí - název` == "10 - Přijat"])
admited_2 <- admited[, .(n_students = .N),
            by = .(program = `Program název`)]


ggplot(admited_2) +
  geom_col()+
  aes(x = `program`, y = n_students)





# how many rejected
rejected <- (dta_app[`Rozh. o přijetí - název` != "10 - Přijat"])
rejected_2 <- rejected[, .(n_students = .N),
                       by = .(program = `Program název`)]


ggplot(rejected_2) +
  geom_col()+
  aes(x = `program`, y = n_students)





# country names translit 
dta_app$`KA - stát` <- iconv(x = dta_app$`KA - stát`,
                            from = "UTF8",
                            to = "ASCII//TRANSLIT")
