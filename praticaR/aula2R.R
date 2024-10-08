
# Instala o pacote
# install.packages("tidyverse")
# carrega o pacote
library(tidyverse)

dados <- read.csv("praticaR/Dados/Pokemon_full.csv")

View(dados)

ggplot(dados, aes(x = weight, y = height))+
  geom_line(color = "red")+
  geom_point(color = "blue", alpha = 0.5)+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )

names(dados)

# ordenar os dados fará com que as ultimas linhas apareçam por ultimo no plot
dados %>%
  arrange(attack) %>%
ggplot(aes(x = weight, y = height, color = attack))+
  geom_point()+
  scale_colour_viridis_c()+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )

# adicionando aesthetic direto na camada

dados %>%
  mutate(
    largura = height/2
  ) %>%
ggplot(aes(x = weight, y = height))+
  geom_point(color = "blue", alpha = 0.5)+
  geom_point(aes(y = largura), color = "red", alpha = 0.5)+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


df <- data.frame(
  x = dados$weight,
  joao = dados$weight/50
)
head(df)



dados %>%
  mutate(
    largura = height/2
  ) %>%
ggplot(aes(x = weight, y = height))+
  geom_point(color = "blue", alpha = 0.5)+
  geom_point(aes(y = largura), color = "red", alpha = 0.5)+
  geom_line(data = df, aes(x = x, y = joao), color = "red", alpha = 0.5)+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


# 
dados %>%
  mutate(
    largura = height/2
  ) %>%
ggplot(aes(x = weight, y = height))+
  geom_point(aes(color = "Height"), alpha = 0.5)+
  geom_point(aes(y = largura, color = "Width"), alpha = 0.5)+
  scale_color_manual(values = c("blue", "red"))+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


dados %>%
  mutate(
    largura = height/2
  ) %>%
ggplot(aes(x = weight, y = height, color = type))+
  geom_point(alpha = 0.5)+
  geom_point(aes(y = largura), alpha = 0.5)+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )



dados %>%
  mutate(
    largura = height/2
  ) %>%
    select(name, height, largura) %>%head

dados %>%
  mutate(
    largura = height/2
  ) %>%
  select(name, height, largura) %>%
  ggplot()+
  geom_boxplot(aes(x = "Altura", y = height))+
  geom_boxplot(aes(x = "Largura", y = largura))



# pivot_longer vai esticar a tabela
# quais colunas quer utilizar?
# o nome das colunas deve ir para uma coluna especifica
# e o valor tbm
dados %>%
  mutate(
    largura = height/2
  ) %>%
    select(name, height, largura) %>%
  pivot_longer(cols = 2:3,
names_to = "Variavel", values_to = "Resultado") %>%
  ggplot()+
  geom_boxplot(aes(x = Variavel, y = Resultado))


dados %>%
  mutate(
    largura = height/2
  ) %>%
    select(name, weight, height, largura) %>%
  pivot_longer(cols = 3:4,
names_to = "Variavel", values_to = "Resultado") %>%
  ggplot()+
  geom_point(aes(x = weight, y = Resultado, shape = Variavel))


# Mais sobre ggplot ---------



# ordenar os dados fará com que as ultimas linhas apareçam por ultimo no plot
dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  ) %>%
  # select(name, height, classe_altura) %>%
  # View()
ggplot(aes(x = weight, y = height, color = classe_altura,
  fill = classe_altura
))+
  geom_point(shape = 21, size = 2)+
  labs(color = "Classe", fill = "Classe")+
    scale_color_manual(values = cores[c(1, 2, 3, 7)])+
      scale_fill_manual(values = cores[c(1, 2, 3, 7)])+
  # scale_color_brewer()
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


# ordenar os dados fará com que as ultimas linhas apareçam por ultimo no plot
install.packages("rcartocolor")
rcartocolor::carto_pal(12, "Bold") %>%scales::show_col()
cores <- rcartocolor::carto_pal(12, "Bold")

p1 <- dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  ) %>%
  group_by(classe_altura) %>%
  summarise(
    media = mean(weight),
    desvio = sd(weight)
  ) %>%
  mutate(
    classe_altura = factor(classe_altura, levels = c("Baixinho", "Pequeno", "Médio", "Altão"))
  ) %>%
  # select(name, height, classe_altura) %>%
  # View()
ggplot(aes(x = classe_altura, y = media, color = classe_altura,
  fill  = classe_altura))+
    geom_errorbar(aes(ymax = media+desvio, ymin = media*0.99),
  color = "black", width = 0.3)+
  geom_col()+
  scale_color_manual(values = cores[c(1, 2, 3, 7)])+
  scale_fill_manual(values = cores[c(1, 2, 3, 7)])+
  scale_x_discrete(breaks = c("Baixinho", "Pequeno", "Médio", "Altão"))+
  theme_bw()+
  labs(x = "Classe da Altura", y = "Peso médio (desvio padrão)")+
  theme(
    # legend.position = c(0.1, 0.8),
    legend.position = "none",
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )
p1

ggsave("./praticaR/outputs/peso_classe.png", plot = p1, device = "png", height = 5, width = 8)


# ordenar os dados fará com que as ultimas linhas apareçam por ultimo no plot
dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  ) %>%
  group_by(classe_altura) %>%
  summarise(
    media = mean(weight),
    desvio = sd(weight)
  ) %>%
  mutate(
    classe_altura = factor(classe_altura, levels = c("Baixinho", "Pequeno", "Médio", "Altão"))
  ) %>%
  arrange(classe_altura) %>%View


dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  ) %>%
  mutate(
    classe_altura = factor(classe_altura, levels = c("Baixinho", "Pequeno", "Médio", "Altão"))
  ) %>%
  # select(name, height, classe_altura) %>%
  # View()
ggplot(aes(x = classe_altura, y = weight, color = classe_altura,
  fill  = classe_altura))+
  geom_violin(alpha = 0.5, size = 1.8)+
  geom_boxplot(color = "black", fill = NA)+
  scale_color_manual(values = cores[c(1, 2, 3, 7)])+
  scale_fill_manual(values = cores[c(1, 2, 3, 7)])+
  scale_x_discrete(breaks = c("Baixinho", "Pequeno", "Médio", "Altão"))+
  scale_y_continuous(trans = "log")+
  theme_bw()+
  labs(x = "Classe da Altura", y = "Peso")+
  theme(
    # legend.position = c(0.1, 0.8),
    legend.position = "none",
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


ggsave("./praticaR/outputs/peso_violin.png", device = "png", height = 5, width = 8)

dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  ) %>%
  mutate(
    classe_altura = factor(classe_altura, levels = c("Baixinho", "Pequeno", "Médio", "Altão"))
  ) %>%
  # select(name, height, classe_altura) %>%
  # View()
ggplot(aes(x = classe_altura, y = weight, color = classe_altura,
  fill  = classe_altura))+
  geom_jitter(alpha = 0.5, width = 0.3, size = 1.8)+
  geom_boxplot(color = "black", fill = NA, width = 0.5)+
  scale_color_manual(values = cores[c(1, 2, 3, 7)])+
  scale_fill_manual(values = cores[c(1, 2, 3, 7)])+
  scale_x_discrete(breaks = c("Baixinho", "Pequeno", "Médio", "Altão"))+
  theme_bw()+
  labs(x = "Classe da Altura", y = "Peso")+
  theme(
    # legend.position = c(0.1, 0.8),
    legend.position = "none",
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


ggsave("./praticaR/outputs/peso.png", device = "png", height = 5, width = 8)



dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  )  %>%
  group_by(classe_altura) %>%
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) %>%
  pivot_longer(cols = c(2, 3), values_to = "Valor", names_to = "Medida") %>%
  mutate(
    Medida = case_when(
      grepl("_h", Medida) ~"Altura",
      TRUE ~ "Peso"
    )
  ) %>%
    mutate(
      classe_altura = factor(classe_altura, levels = c("Baixinho", "Pequeno", "Médio", "Altão"))
    )%>%
  ggplot(aes(x = classe_altura, y = Valor, color = Medida, fill = Medida))+
  geom_col(position = position_dodge())+
    scale_color_manual(values = cores[c(1, 2, 3, 7)])+
    scale_fill_manual(values = cores[c(1, 2, 3, 7)])+
  theme_bw()+
    theme(
      axis.title = element_text(size = 18, face = "bold"),
      axis.text = element_text(size = 16, face = "plain")
    )


# eixo secundario


df <- dados %>%
  mutate(
    classe_altura = case_when(
      height < 5 ~ "Baixinho",
      height < 50 ~ "Pequeno",
      height < 100 ~ "Médio",
      TRUE ~ "Altão"
    )
  )  %>%
  group_by(classe_altura) %>%
  summarise(
    media_h = mean(height),
    media_w = mean(weight)
  ) %>%
  pivot_longer(cols = c(2, 3), values_to = "Valor", names_to = "Medida") %>%
  mutate(
    Medida = case_when(
      grepl("_h", Medida) ~"Altura",
      TRUE ~ "Peso"
    )
  ) %>%
    mutate(
      classe_altura = factor(classe_altura, levels = c("Baixinho", "Pequeno", "Médio", "Altão"))
    )

max_alt <- df %>%
  filter(Medida == "Altura") %>%
  arrange(desc(Valor)) %>%
  distinct(Medida, .keep_all = TRUE) %>%pull(Valor)

max_peso <- df %>%
  filter(Medida == "Peso") %>%
  arrange(desc(Valor)) %>%
  distinct(Medida, .keep_all = TRUE) %>%pull(Valor)


fator <- max_peso/max_alt

df %>%
  mutate(
    Valor2 = ifelse(Medida == "Altura", Valor*fator, Valor)
  ) %>%
ggplot(aes(x = classe_altura, y = Valor2, color = Medida, fill = Medida))+
  geom_col(position = position_dodge())+
    scale_color_manual(values = cores[c(1, 2, 3, 7)])+
    scale_fill_manual(values = cores[c(1, 2, 3, 7)])+
  scale_y_continuous(
     # Add a second axis and specify its features
     sec.axis = sec_axis(~./fator, name="Média do Altura")
  )+
  labs(y = "Média do Peso")+
  theme_bw()+
  theme(
    axis.title = element_text(size = 18, face = "bold"),
    axis.text = element_text(size = 16, face = "plain")
  )


