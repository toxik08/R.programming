cat("1: Add\n2: Subtract\n3: Multiply\n4: Divide\n")
choice <- as.integer(readline("Enter choice (1-4): "))
num1 <- as.numeric(readline("Enter first number: "))
num2 <- as.numeric(readline("Enter second number: "))

result <- switch(choice,
    num1 + num2,
    num1 - num2,
    num1 * num2,
    if (num2 != 0) num1 / num2 else "Division by zero error",
    "Invalid choice"
)

cat("Result:", result, "\n")
