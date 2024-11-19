
# using nomedopacote

using Plots
using Random

#? Referencia ótima!
#? https://www.youtube.com/@doggodotjl

#* do repositorio do doggodotjl
#* https://github.com/julia4ta/tutorials/blob/master/Series%2006/Files/julia_cheatsheet.jl

#? Motivação

function check(x, v)
    x ∈ v
end

x = 2

v = rand(1:10000, 100000000);

@time check(23, v)


#! trabalhando
# hello world
println("Hello, World!")

# comment (ctrl+/)
# this is a comment
#=
    this is a
    multiline comment
=#

# ctrl+l to clear repl

# arithmetic
1 + 1
2 - 1
2 * 3
4 / 2
5 / 2
2^3
5 % 2
1 + (2 * 3)^4 * 5

# boolean
3 < 2
3 >= 3
4 == 2 * 2
2 * 2 != 4
true && false
true || false
false + true

# variable
x = 1
y = 2
z = x + y
x
y
z
x = 2
x
y
z
z = x + y
z

const d = 4
d = 40
d = 40.0 #will result in error

#variable part 2
i = 1
i = i + 1
i += 1
# i++ does not work in Julia

height = 2
width = 3
area = height * width

# number
typeof(-3)
typeof(1.2)
0.1 + 0.2
typeof(pi)
1000000 == 1_000_000
sqrt(4)
round(3.14159, digits = 2)

# = variable assignment operator
# == equality test
# === identity test
123 == "123"
# 123 + "123" does not work in Julia
# 123 - "123" does not work in Julia

# string part 1
typeof('a')
typeof("a")
# typeof('Hello') does not work in Julia
typeof("Hello")
println("""This is "great".""")
println("1\n2\n3")
println("1\t2\t3")

# string part 2
s1 = "Hello,"
s2 = "World!"
s1_s2_concat = s1 * " " * s2
s3 = "Thomas"
println("My name is $s3 Vilches.")

# string part 3
number123 = 123
string123 = "123"
number_to_string = string(number123)
string_to_number = parse(Int64, string123)

# dictionary part 1
dog = Dict(
    "name" => "eggdog",
    "age" => 2,
    "breed" => "egg-dog mix"
)
dog["name"]
dog["age"]

# dictionary part 2
dog["name"] = "Doggo"
dog["email"] = "doggo@doggo.doggo"
dog
pop!(dog, "email")
dog

# struct
mutable struct Dog
    name::String
    age::Integer
    breed::String
end
dog1 = Dog("eggdog", 2, "egg-dog mix")
dog1.name
dog1.name = "Doggo"

dog2 = Dog("Thor", 10, "pug")
dog2.name

# dog1.email = "doggo@doggo.doggo" does not work in Julia

# array part 1
scalar = [1]
vector = [1, 2, 3]
vector[2]
vector[3] * 4
length(vector)

vector[end-1]

# array part 2
sum(vector)

# array part 3
sort(vector, rev = true)
vector
sort!(vector, rev = true)
vector

# array part 4
push!(vector, 4)
# push(vector, 5)
pop!(vector)
vector
matrix = [1 2 3; 4 5 6]

vector .* 2

# for(i = 0; i<3; i++)
#     v[i] = v[i]+2


# control flow (conditional)
x = 3
y = 2
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

x, y = y, x
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

x = y
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

# control flow (ternary)
x = 1
y = 2
x > y ? println("$x > $y") : println("$x <= $y")
a = x > y ? 1 : 2

x, y = y, x
x > y ? println("$x > $y") : println("$x <= $y")

x = y
x > y ? println("$x > $y") : println("$x <= $y")

# control flow (while loop)
i = 1
while i <= 10
    println(i)
    i += 1
end
# use ctrl+c to abort infinite loop

# control flow (for loop)
for i in 1:10
    println(i)
end

# control flow (for/in loop over dictionary)
dog = Dict(
    "name" => "eggdog",
    "age" => 2,
    "breed" => "egg-dog mix"
)
for (key, value) in dog
    println("key = $key\tvalue = $value")
end

# control flow (for/in loop over array)
array = [10, 20, 30]
for i in array
    println(i)
end

# control flow (array/list comprehension)
[i*2 for i in 1:10]

# control flow (for/in loop over string)
s = "Hello, World!"
for i in s
    println(i)
end

# function
function myadd(x, y)
    x + y
end

myadd(2, 3)


## Functions and methods
function my_add(x::Int64, y::Int64)
    println("A soma dos números inteiros é:", x + y)
end

my_add(1, 2)
# my_add(1.0, 2)

function my_add(x::Float64, y::Float64)
    println("A soma dos números reais é:", x + y)
end

my_add(1, 2)
my_add(1.0, 2.0)
my_add(1.0, 2)

function my_add(x, y)
    println("A soma dos números quaiquer é:", x + y)
end

my_add(1, 2)
my_add(1.0, 1.0)
my_add(1, 1.0)


# anonymous function
staff = [
    "Dabbling",
    "Dodgy",
    "Dapper"
]
map(length, staff)
map(x -> x * " Doggo", staff)


#? plotting
#? Checar o manual
#* https://docs.juliaplots.org/stable/tutorial/

using RDatasets
using Plots


iris = dataset("datasets", "iris")

# iris$SepalLength
iris.SepalLength
names(iris)

Plots.scatter(
    iris.SepalLength,
    [iris.SepalWidth, iris.PetalLength],
    labels = ["Sepal width" "Petal length"]
)

xlabel!("Comprimento da Sépala")
ylabel!("Comprimento da Pétala")

scatter!(iris.SepalLength, iris.PetalWidth, label = "Petal width")


##

using StatsBase
using StatsPlots

# macro
#df 

typeof(:teste)

@df iris scatter(:SepalWidth, [:PetalWidth, :PetalLength],
    labels = ["Petal width" "Petal length"],
    mc = [:purple :blue]
)



@df iris scatter(:SepalWidth, :PetalWidth,
    marker_z = :SepalLength,
    labels = [nothing "Sepal Length"],
    color = :jet,
    colorbar_title = "Sepal Length",
    xlabel = "Sepal Width", ylabel = "Petal Width"
)


# Plots aceita funções genéricas

f(x) = 2*x
g(x) = x^2


plot([f, g])


v = [1, 2, 3]

(v .+ 1) .* 2
@. (v + 1) * 2

# Combinando Plots
x = range(0, 10, length=100)
y1 = @. exp(-0.1x) * cos(4x)
y2 = @. exp(-0.3x) * cos(4x)
y3 = @. exp(-0.5x) * cos(4x)
plot(x, [y1 y2 y3], layout=(3, 1), legend=false)


#? ou
x = range(0, 10, length=100)
y1 = @. exp(-0.1x) * cos(4x)
y2 = @. exp(-0.3x) * cos(4x)
y3 = @. exp(-0.1x)
y4 = @. exp(-0.3x)
y = [y1 y2 y3 y4]

p1 = plot(x, y);
p2 = plot(x, y, title="Title 2", lw=3);
p3 = scatter(x, y, ms=2, ma=0.5, xlabel="xlabel 3");
p4 = scatter(x, y, title="Title 4", ms=5, ma=0.2);
plot(p1, p2, p3, p4, layout=(2,2), legend=false)


function f(x, y)

    x < y

end


f(3,3)

f([2; 3], 3)

[2; 3] .< 3

map(k -> f(k, 3), [2; 3])
map(k -> f(k, 3), [5; 7; 6; 3])


######################################################################################
# Estimando Π
#####################################################################################


# πR^2 = Ac
# Circulo inscrito em um quadrado
# sabemos que a área do quadrado é 4xR^2
# Portanto Ac/Aq = π/4
# Vamos usar simulações de monte carlo para fazer isso


# Aq = 4R^2
# Ac = πR^2
# prob = Ac/Aq
# prob = πR^2/4R^2
# π = 4 prob
# π = 4 N_circulo/N_total


using Plots


N = 1000000 # numero de pontos


function calculate_pi(N)
    r = 1
    x = -r .+ (2*r) .* rand(N)
    y = -r .+ (2*r) .* rand(N)
    
    result = x.^2 .+ y.^2 .< r
    
    π = 4*sum(result)/length(result)
    π
end


calculate_pi(100000000)
calculate_pi(10000000)


using Plots


## paralelizando

N = 1000000
function run_sim()
    r = 1
    x = -r .+ (2*r) .* rand()
    y = -r .+ (2*r) .* rand()
    
    result = x^2 + y^2 < r
    result
end



@time teste = map(x-> run_sim(), 1:1000000)
4*sum(teste)/length(teste)

##
using Distributed

nprocs()
addprocs(4)

@time teste = pmap(x -> run_sim(), 1:1000000)
4*sum(teste)/length(teste)

# precisa adicionar em todos os processadores
@everywhere function run_sim()
    r = 1
    x = -r .+ (2*r) .* rand()
    y = -r .+ (2*r) .* rand()
    
    result = x^2 + y^2 < r
    result
end




@everywhere function calculate_pi(N)
    r = 1
    x = -r .+ (2*r) .* rand(N)
    y = -r .+ (2*r) .* rand(N)
    
    result = x.^2 .+ y.^2 .< r
    
    π = 4*sum(result)/length(result)
    π
end



N = Int(1000000/(nprocs()-1))

@time result = pmap(k-> calculate_pi(k), repeat([N], 4))

using StatsBase
mean(result)

using StatsBase





######################################################################################
# ODE
#####################################################################################

using Plots, DifferentialEquations

# vamos encontrar a solução da função de crescimento

# f(u,t,p) = du/dt = u

f(u, p, t) = u

# definindo o problema

u0 = [2.0]
tspan = [0, 1000]
prob = ODEProblem(f, u0, tspan)

# resolvendo o problema
sol = solve(prob, Tsit5())

sol.u

plot(sol)

# mudando parametros


f(u, p, t) = p[1]*u

u0 = [2.0]
tspan = [0, 1000]
p = [2.0]
prob = ODEProblem(f, u0, tspan, p)


# resolvendo o problema
sol = solve(prob, Tsit5())
plot(sol)




#### Logistica

f(u, p, t) = p[1].*(1 .- u/p[2]).*u

u0 = [2.0]
tspan = [0, 20]
p = [2.0, 500]
prob = ODEProblem(f, u0, tspan, p)


# resolvendo o problema
sol = solve(prob, Tsit5())
plot(sol,
    legend = false
)


### Sistema de equações diferenciais

function f!(du, u, p, t)
    # 
    du[1] = p[1]*u[1] - p[2]*u[1]*u[2] # dx/dt = αx-βxy
    du[2] = p[3]*u[1]*u[2] - p[4]*u[2] # dy/dt = δxy-μy
    return du
end


u0 = [2.0, 4.0]
tspan = [0, 10]
p = [10.0, 2.0, 1.5, 5.0]

prob = ODEProblem(f!, u0, tspan, p)

sol = solve(prob,Tsit5())

plot(sol)

solucao = Matrix(hcat(sol.u...)')


plot(sol.t, solucao)



## dt necessario para RK
sol = solve(prob,RKO65(), saveat = 1e-2, dt = 1e-2)
#sol = solve(prob,Tsit5(), saveat = 1e-2)

plot(sol)
solucao = Matrix(hcat(sol.u...)')
plot(sol.t, solucao)



plot(solucao[:, 1], solucao[:, 2],
    xaxis = "Presa",
    yaxis = "Predador"
)


u0 = [2.001, 4.0]
tspan = [0, 10]
p = [10.0, 2.0, 1.5, 5.0]

## dt necessario para RK
prob = ODEProblem(f!, u0, tspan, p)
sol = solve(prob,RKO65(), saveat = 1e-2, dt = 1e-2)
solucao = Matrix(hcat(sol.u...)')


plot!(solucao[:, 1], solucao[:, 2],
    color = :orange,
    legend = false
)


#? Brincadeira

function lorenz!(du,u,p,t)
    du[1] = 10.0(u[2]-u[1])
    du[2] = u[1]*(28.0-u[3]) - u[2]
    du[3] = u[1]*u[2] - (8/3)*u[3]
end


   u0 = [1.0;0.0;0.0]
   tspan = (0.0,100.0)
   prob = ODEProblem(lorenz!,u0,tspan)
   
   # Test that it worked
#    using OrdinaryDiffEq
    sol = solve(prob,Tsit5())
    plot(sol,vars=(1,2,3))


   
   u0 = [1.001;0.0;0.0]
   tspan = (0.0,100.0)
   prob = ODEProblem(lorenz!,u0,tspan)
   
   # Test that it worked
#    using OrdinaryDiffEq
   sol = solve(prob,Tsit5())
   plot!(sol,vars=(1,2,3))

   #############################################

   using TidierPlots

   ggplot(iris)+
   geom_point(@aes(x = SepalLength, y = SepalWidth, color = Species))+
   theme_minimal()