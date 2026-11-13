%let dsn=sashelp.cars;
%let numx=MPG_City;
%let xvar=Origin;
%let yvar=Type;
%let fill_var=Invoice;

proc r;
submit;
library(ggplot2)
library(dplyr)
library(scales)

numx     <- symget("numx")
dsn      <- symget("dsn")
xvar     <- symget("xvar")
yvar     <- symget("yvar")
fill_var <- symget("fill_var")

data <- sd2df(dsn)


p2 <- ggplot(data, aes(x = .data[[numx]], y = .data[[fill_var]])) +
  geom_point(aes(color = .data[[yvar]]), alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  scale_x_continuous(labels = comma) +
  theme_minimal() +
  labs(title = paste(numx, "vs", fill_var),
        x = numx,
        y = fill_var)
 
rplot(p2)


heat_df <- data %>%
  group_by(.data[[yvar]], .data[[xvar]]) %>%
  summarise(
    total_var = sum(.data[[fill_var]], na.rm = TRUE),
    .groups = "drop"
  )


p3 <- ggplot(
        heat_df,
        aes(
          x = .data[[xvar]],
          y = .data[[yvar]],
          fill = total_var
        )
      ) +
      geom_tile() +
      scale_fill_gradient(
        low = "white",
        high = "steelblue",
  labels = label_number(
    scale = 1e-6,
    suffix = "M",
    accuracy = 0.1
  )
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(
          angle = 45,
          hjust = 1
        )
      ) +
      labs(
        title = paste(yvar, "vs", xvar),
        x = xvar,
        y = yvar
      )

rplot(p3)
 
endsubmit;
run;