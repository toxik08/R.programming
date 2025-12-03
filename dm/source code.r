# Install and load necessary packages
install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

# Load the Groceries dataset
data("Groceries")
summary(Groceries)

# Generate frequent itemsets with a minimum support of 1%
frequent_items <- apriori(Groceries,
                          parameter = list(supp = 0.01, target = "frequent itemsets"))
inspect(head(frequent_items, 10))

# Generate association rules with minimum support of 1% and confidence of 30%
rules <- apriori(Groceries,
                 parameter = list(supp = 0.01, conf = 0.3))
inspect(head(rules, 10))

# Visualize the rules using a scatter plot
plot(rules)

# Visualize the rules using a graph-based method
plot(rules, method = "graph", engine = "htmlwidget")

# Visualize the rules using a grouped matrix method
plot(rules, method = "grouped")

