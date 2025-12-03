scores <- c(75, 82, 60, 95, 40)

all_passed <- all(scores >= 60)
any_failed <- any(scores < 60)

cat("All students passed:", all_passed, "\n")
cat("At least one student failed:", any_failed, "\n")
