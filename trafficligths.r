signal <- readline("Enter traffic light color (red/yellow/green): ")

message <- switch(tolower(signal),
    "red" = "Stop",
    "yellow" = "Ready",
    "green" = "Go",
    "Invalid signal"
)

cat("Message:", message, "\n")
