library(tidyverse)

dados_hosp <- read.csv2("./praticaR/Dados/morbilidade-e-mortalidade-hospitalar.csv")

glimpse(dados_hosp)



dados_hosp <- dados_hosp %>%
  mutate(
    #Taxa.Internamento = as.numeric(Taxa.Internamento),
    #Taxa.Mortalidade = as.numeric(Taxa.Mortalidade)
    across(starts_with("Taxa"), ~as.numeric(.))
  )

# uso do across
dados_hosp %>%
  mutate(
    #Taxa.Internamento = as.numeric(Taxa.Internamento),
    #Taxa.Mortalidade = as.numeric(Taxa.Mortalidade)
    across(where(is.numeric), ~./2)
  ) %>%glimpse()


dados_hosp %>%
  pull(Região) %>%unique()

dados_hosp %>%
  pull(Instituição) %>%unique()


dados_hosp %>%
  select(Região, Instituição) %>%
  unique %>%
  group_by(Região) %>%
  summarise(n = n()) %>%
  ggplot()+geom_col(aes(x = Região, y = n))

dados_hosp %>%
  pull(Trimestre) %>%unique


dados_hosp %>%
  pull(Ano) %>%unique()

dados_hosp %>%
  group_by(Instituição, Trimestre, Ano) %>%
  summarise(
    S = sum(Taxa.Mortalidade)
  )

dados_hosp %>%
  group_by(Instituição, Trimestre, Ano) %>%
  summarise(
    S = sum(Taxa.Internamento)
  )

dados_hosp %>%
  pull(Descrição.Capítulo.Diagnóstico.Principal) %>%unique

dados_hosp %>%
  ggplot(aes(y = Descrição.Capítulo.Diagnóstico.Principal, x = Taxa.Mortalidade))+
  geom_jitter(color = "blue", alpha = 0.3)+
  geom_boxplot(fill = NA)+
  theme_bw()

ggsave("./praticaR/outputs/mortalidade.png", width = 12, height = 10)
