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


# Aula dia 15/10 -------------



dados <- read.csv("praticaR/Dados/Pokemon_full.csv")

glimpse(dados)


ggplot(dados) +
  geom_point(aes(x = weight, y = height, color = type)) +
  geom_line(aes(x = weight, y = height, color = type)) +
  geom_hline(aes(yintercept = 50, linetype = "TESTE"), color = "blue") +
  guides(
    color = guide_legend(
      override.aes = list(linetype = NA, shape = "square", size = 3)
    ),
    linetype = guide_legend(
      override.aes = list(color = "black", size = 3, linewidth = 1.5)
    )
  ) +
  theme_bw()


dados %>%
  group_by(type) %>%
  summarise(
    n = n()
  ) %>%arrange(desc(n))


dados %>%
  filter(grepl("^ice$|^fairy$", type)) %>%
  ggplot() +
  geom_point(aes(x = weight, y = height, group = type)) +
  geom_line(aes(x = weight, y = height, group = type)) +
  guides(
    color = guide_legend(
      override.aes = list(linetype = NA, shape = "square", size = 3)
    ),
    linetype = guide_legend(
      override.aes = list(color = "black", size = 3, linewidth = 1.5)
    )
  ) +
  theme_bw()



# Aula dia 15/10 -------------

m <- matrix(c(1, 2,3, 4, 5,6,7,8,9), ncol = 3)

soma_ao_quadrado <- function(x){
  sum(x^2)
}

apply(m, 1, sum)
apply(m, 2, sum)
apply(m, 2, function(x) sum(x^2))




dados %>%
  group_by(type) %>%
  summarise(
    n = n()
  ) %>%arrange(desc(n))

#! quero criar uma função que vai fazer o gráfico para mim

t <- "fire"

constroi_grafico <- function(t, df){
  df %>%
    filter(type == t) %>%
    ggplot() +
    geom_point(aes(x = weight, y = height), color = "black") +
    geom_line(aes(x = weight, y = height), color = "black") +
    guides(
      color = guide_legend(
        override.aes = list(linetype = NA, shape = "square", size = 3)
      ),
      linetype = guide_legend(
        override.aes = list(color = "black", size = 3, linewidth = 1.5)
      )
    ) +
    labs(title = t) +
    theme_bw()
}

v <- dados %>%
  pull(type) %>% unique


# roda o lapply
graficos <- lapply(v, constroi_grafico, df = dados)

# roda o lapply para salvar os gráficos
lapply(1:length(graficos),
  function(x) ggsave(filename = paste0("./outputs/pokemon/grafico", x,".png"), plot = graficos[[x]], width = 5)
)


# roda o lapply e concatena
lapply(c(1, 2, 3, 4), function(x) x^2) %>% 
Reduce(rbind, .)

#Reduce(lista, função que usa para juntar)

constroi_sumario <- function(t, df){
  df %>%
    filter(type == t) %>%
    summarise(minimo = min(height), maximo = max(height)) %>%
    mutate(type = t)
}

# roda o lapply e junta em um data.frame
lapply(v, constroi_sumario, df = dados) %>%
  Reduce(rbind, .)

dados %>%
  filter(height != 38) %>%
  constroi_sumario("fire", .)
