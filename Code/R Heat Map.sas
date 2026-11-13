proc r;
submit;
library(ggplot2)
library(dplyr)
 
shoes_df <- sd2df("sashelp.shoes")
 
shoes_df$Region <- as.factor(shoes_df$Region)
shoes_df$Product <- as.factor(shoes_df$Product)

heat_df <- shoes_df %>%
  group_by(Region, Product) %>%
  summarise(total_sales = sum(Sales, na.rm = TRUE))
 
p3 <- ggplot(heat_df, aes(x = Product, y = Region, fill = total_sales)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "steelblue") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Sales Heatmap: Region vs Product",
       x = "Product",
       y = "Region")
 
rplot(p3)
 
endsubmit;
run;