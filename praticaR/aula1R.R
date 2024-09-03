
# Instala o pacote
# install.packages("tidyverse")
# carrega o pacote
library(tidyverse)

#! oljasdfoijasdiopfupasidjf
#? asdasdasd
#* asdasdasdasd 
# todo

a = 1

a <- 1
a <- 2

a


a <- 1
b <- 2
a+b


# Carregando dados --------------
getwd()
dados <- read.csv("praticaR/Dados/Pokemon_full.csv")

# comando de visualização
head(dados, 20)
tail(dados, 20)
View(dados)

names(dados)

#? dplyr
summary(dados)

df <- filter(dados, height > 10)
df <- select(dados, name, height, weight)

# c(1, 2, 3)+c(1, 2, 3)

# IMC = peso/(altura*altura) cria uma coluna nova
df <- mutate(df, imc = weight/(height*height))
# altera coluna existente
mutate(df, weight = 2*weight)

#? A biblioteca dplyr possui o operador "pipe"
#? dado por  %>%
#? Ele "pega" tudo que está à esquerda dele e coloca como primeiro elemento
#? da função à direita.
#? Também é possível usar o operador "."
#? para especificar onde ele deve substituir. 


df <- filter(dados, height > 10)
df <- select(df, name, height, weight)
df <- mutate(df, imc = weight/(height*height))

filter(dados, height > 10)

dados %>%
  filter(height > 10) 

df <- dados %>%
  filter(height > 10) %>%
  select(name, height, weight)%>%
  mutate(imc = weight/(height*height))

 dados |> # pipe nativo do R
  filter(height > 10) %>%
  select(name, height, weight)%>%
  mutate(imc = weight/(height*height))

#? comando JSON para o pipe do dplyr
# {
#   "key": "Ctrl+Shift+m",
#   "command": "type",
#   "args": { "text": " %>%" },
#   "when": "editorTextFocus && editorLangId == 'r'"
# },
# {
#   "key": "Ctrl+Shift+m",
#   "command": "type",
#   "args": { "text": " %>%" },
#   "when": "positronConsoleFocused && editorLangId == 'r'"
# }


dados %>%
  group_by(type) %>%
  summarise(m = mean(height), s = sd(height))

dados %>%
  group_by(type) %>%
  mutate(m = mean(height), s = sd(height)) %>%
  ungroup() %>%
  filter(height > m)
