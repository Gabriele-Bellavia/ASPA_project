# Install packages if necessary:
# install.packages(c("dplyr", "ggplot2"))

library(dplyr)
library(ggplot2)

# Read the dataset
data <- read.csv("dataset.csv")

# Check the column names first
names(data)
# Select the required observations
data_analysis <- data %>%
  filter(
    !is.na(`body mass`),
    !is.na(`metabolic rate`),
    `metabolic rate - method` == "basal metabolic rate",
    `body mass` > 0,
    `metabolic rate` > 0
  ) %>%
  filter(class %in% c("Aves", "Mammalia")) %>%
  mutate(
    log_mass = log(`body mass`),
    log_metabolic_rate = log(`metabolic rate`)
  )
unique(data$class)
ggplot(data_analysis,
       aes(x = `body mass`,
           y = `metabolic rate`,
           color = class)) +
  
  geom_point(alpha = 0.6, size = 2) +
  
  scale_x_log10() +
  scale_y_log10() +
  
  labs(
    title = "Basal Metabolic Rate vs Body Mass",
    x = "Body Mass (kg)",
    y = "Metabolic Rate (W)",
    color = "Taxonomic Group"
  ) +
  
  theme_minimal()
# Install once if needed:
# install.packages("brms")

library(brms)
model_data <- data_analysis %>%
  select(log_mass, log_metabolic_rate) %>%
  na.omit()
nrow(model_data)
model_beta <- brm(
  formula = log_metabolic_rate ~ log_mass,
  
  data = model_data,
  
  family = gaussian(),
  
  prior = c(
    prior(normal(0, 10), class = "Intercept"),
    prior(normal(0, 2), class = "b"),
    prior(student_t(3, 0, 2.5), class = "sigma")
  ),
  
  chains = 4,
  iter = 4000,
  warmup = 2000,
  cores = 4,
  seed = 1234
)
posterior_beta <- as_draws_df(model_beta)

beta_samples <- posterior_beta$b_log_mass
summary(beta_samples)
quantile(
  beta_samples,
  probs = c(0.025, 0.5, 0.975)
)
ggplot(
  data.frame(beta = beta_samples),
  aes(x = beta)
) +
  geom_density() +
  geom_vline(
    xintercept = 0.75,
    linetype = "dashed"
  ) +
  labs(
    title = "Posterior Distribution of the Allometric Exponent",
    x = expression(beta),
    y = "Posterior Density"
  ) +
  theme_minimal()
