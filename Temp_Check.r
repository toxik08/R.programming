temp <- c(32, 35, 29, 40, 38)

all_hot <- all(temp >= 30)
any_below30 <- any(temp < 30)

cat("All days were hot (>=30):", all_hot, "\n")
cat("At least one day was below 30:", any_below30, "\n")
