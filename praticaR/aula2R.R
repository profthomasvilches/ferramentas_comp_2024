
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
