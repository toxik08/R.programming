nums <- c(2, 4, 5, 8)

all_even <- all(nums %% 2 == 0)
any_even <- any(nums %% 2 == 0)

cat("All numbers are even:", all_even, "\n")
cat("At least one number is even:", any_even, "\n")
