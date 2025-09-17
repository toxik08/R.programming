grade <- readline("Enter grade (A, B, C, D, F): ")

meaning <- switch(toupper(grade),
    "A" = "Excellent",
    "B" = "Good",
    "C" = "Average",
    "D" = "Poor",
    "F" = "Fail",
    "Invalid grade"
)

cat("Meaning:", meaning, "\n")
