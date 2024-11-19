# checando

check <- function(x, v){
    x %in% v
}

v = sample(1:10000, 100000000, replace = TRUE)

tictoc::tic()
check(23, v)
tictoc::toc()

microbenchmark::microbenchmark(a = check(23, v), unit = "seconds", times = 20L)


v = c("Name" = "blablabla")
v["Name"]

v  <- c(1 ,2 ,3)
v[length(v)]


# if(){

# }else{
#     if(){
        
#     }else{

#     }
# }

my_add <- function(x, y){
    x + y
}



v + 1


c(1, 2, 3) + 2

x = 2
ifelse(x == 1, "x igual a 1", "x diferente de 1")
