
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

dados %>% head
  dados %>%
  filter(height > 10) %>%
  select(name, height, weight)%>%
  mutate(imc = weight/(height*height)) %>% 
  ggplot()+
  geom_density(aes( x = imc))

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


# magritt

glimpse(dados)
head(dados)

dados %>%
  group_by(type, secundary.type) %>%
  summarise(m = mean(height), s = sd(height))

dados %>%
  group_by(type) %>%
  mutate(
    m = mean(height),
    s = sd(height)
  ) %>%
  ungroup() %>%
  filter(height > m)


dados %>%
  group_by(type) %>%
  mutate(
    existe = any(grepl("saur", name))
  )  %>% View()

grepl("saur", "Venosaur")
grepl("saur", "Charmander")
grepl("saur", c("Venosaur", "Charmander")) %>% any()

grepl("saur", "Charmander") # Regex

x <- c("Venosaur", "BulbaSaur")
grepl("[Ss]aur", x) # Regex

x <- c(
  "Amonia",
  "Ferro",
  "Dióxido de enxofre",
  "Dioxido de Enxofre",
  "Manganês",
  "Dióxido  de  Enxofre",
  "dioxido de  Enxofre",
  "dioxidode  Enxofre"
)

# + um ou mais
# * zero ou mais
grepl("[Dd]i[óo]xido *de\\s+[eE]nxofre", x)

n <- c("097.765.986-90", "123.765.98-37")
grepl("\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}", n)

grepl(".", c("a", "b", "c", "0", " "))

dados %>% 
filter(grepl("saur", name))

# JOINS
# Left, Right, Inner, Full

df <- dados %>% 
group_by(type) %>% 
summarise(m = mean(height, na.rm=FALSE)) %>% 
ungroup()

left_join(dados, df, by = "type") %>% View


df1 <- df %>% 
filter(type != "grass") %>% 
bind_rows(
  data.frame(type = "thomas", m = 2)
)

# mantem da esquerda e joga fora da direita
left_join(dados, df1, by = "type") %>% View
# mantem da direita e joga fora da esquerda
right_join(dados, df1, by = "type") %>% View
# mantem só o que tem correspondencia
inner_join(dados, df1, by = "type") %>% View
# mantem tudo
full_join(dados, df1, by = "type") %>% View


df2 <- df1 %>% arrange(desc(type))

bind_cols(df1, df2)
bind_rows(df1, df2)

df1 %>%
rename(tipo = type) %>% 
bind_rows(df2) %>% View


# Com duas variaveis


df <- dados %>% 
group_by(type, secundary.type) %>% 
summarise(m = mean(height, na.rm=FALSE)) %>% 
ungroup()

dados %>% 
  left_join(df, by = c("type", "secundary.type")) %>% 
  View

dados %>% 
  left_join(df) %>% 
  View


dados %>% filter(type == "bug")

#! Cuidado com join
#! cada combinaçao possível gera uma linha
dados %>% 
  left_join(df, by = "type") %>% 
  View

View(dados)


#? Filtrar todos os pokemons com bee ou bel no nome

dados %>%
  filter(grepl("[Bb]ee", name) | grepl("[Bb]el", name))

dados %>%
  filter(grepl("[Bb]ee|[Bb]el", name))

dados %>%
  filter(grepl("[Bb]e[el]", name))

dados[grepl("[Bb]e[el]", dados$name),]

grepl("[Bb]ee", dados$name)
grepl("[Bb]el", dados$name)


is.numeric(2)
is.numeric("thomas")

# para saber que existem

f <- function(x, y, z){

  return(paste("O valor de x é", ncol(x), "'e o valor de z é ", nrow(z)))

}

dados %>%
  f(., 2, .)


#? aplicar função em mais de uma variável/coluna

dados %>%
  mutate_if(is.numeric, scale) %>%
  select_if(is.numeric) %>%
  lm(height ~ weight, .)

dados %>%
  mutate(across(c('height', 'weight'), ~ scale(.)))

dados %>%
  mutate(across(contains("ght"), ~ scale(.)))

dados %>%
  summarise(across(contains("ght"), ~ mean(.)))
