# Repo for the project for Advanced Statistics and Physics Analysis course.

----------------------------------

## Project: Allometric scaling in animals: is Kleiber's law universal?

Question: many biological quantities follow approximate power-law scaling relationships. Does animal basal metabolic rate $B$ scale with body mass according to Kleiber’s law,
$B \propto  M^{3/4}$, or is the exponent different? Is a single exponent adequate for all animals, or do
different taxonomic groups have different scaling exponents?

To do so, we work under the Bayesian framework using three main model. Let $M_i$ be body mass and $B_i$ metabolic rate. Given log-log space: 

$$x_i = \log M_i, \qquad y_i = \log B_i$$

- Model 1: Kleiber fixed-exponent models:

$$y_i = \alpha + \frac{3}{4} x_i + \epsilon_i, \quad \epsilon_i \sim \mathcal{N}(0,\sigma^2)$$

- Model 2: free allometric exponent:

$$y_i = \alpha + \beta x_i + \epsilon_i, \quad \epsilon_i \sim \mathcal{N}(0,\sigma^2)$$

- Model 3: group dependentt scaling:

$$y_i = \alpha_{g[i]} + \beta_{g[i]} x_i + \epsilon_i, \quad \epsilon_i \sim \mathcal{N}(0,\sigma^2)$$

where $g[i]$ denotes the taxonomic group of observation $i$.

Workflow:

Data sources:
- Dataset page: https://animaltraits.org/

- Zenodo record: https://zenodo.org/records/6468938

- Direct data file: https://zenodo.org/records/6468938/files/observations.csv

- Column documentation: https://zenodo.org/records/6468938/files/column-documentation.csv

Ref.
- M. Kleiber, The Fire of Life: An Introduction to Animal Energetics, Wiley (1961).

- M. E. Herberstein et al., “AnimalTraits – a curated animal trait database for body mass,
metabolic rate and brain size”, Scientific Data 9, 265 (2022)
