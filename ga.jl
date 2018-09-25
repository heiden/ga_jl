using DelimitedFiles, StatsBase, RandomNumbers, Distributions
include("class.jl")#=, include("selection.jl")=#, include("crossover.jl"), include("mutation.jl")

# include("ga.jl") --> Benchmark

function params(solver::ga)
	println("Cx: ", solver.cx)
	println("Mr: ", solver.mr)
	println("Elitist: ", solver.elitist)
	println("Population + Fitness:")
	for i in 1:length(solver.fitness)
		println(solver.population[i], " : " , solver.fitness[i])
	end
	println("Fitness: ", solver.fitness)
	println("Total fitness: ", solver.total_fitness)
end

function every_fitness(solver::ga)
	for ind in solver.population
		f = calc_fitness(ind)
		solver.total_fitness += f
		append!(solver.fitness, f)
	end
end

function calc_fitness(ind)
	fs, ss = 0.0, 0.0
	a, b = 20, 0.2
	for i in ind
		fs += i^2
		ss += cos(2 * π * i)
	end
	n = length(ind)
	return -a * exp(-b * sqrt(fs/n)) - exp(ss/n) + a + exp(1)
end

function print_graph(graph)
	for i = 1:length(graph)
		println(graph[i,:])	
	end
end

function random_solve(size, lb, ub)
    # return sample(1:size, size, replace = false)
    rng = MersenneTwisters.MT19937()
    return rand(rng, lb:ub, size)
end

function scan_ackley(file)
	lines = readlines(file)
	return tryparse(Int32, lines[1]), tryparse(Int32, lines[2]), tryparse(Float64, lines[3]), tryparse(Float64, lines[4]), tryparse(Float64, lines[5]), tryparse(Float64, lines[6])
end

file = "ackley.in"
dim, pop_sz, cx, mr, lb, ub = scan_ackley(file)
# global w = readdlm(file, Int)
# print_graph(w)

pp = [random_solve(dim, lb, ub) for x in 1:pop_sz]
cx = 0.96
mr = 0.03

solver = ga(cx, mr, pp)
# solver = ga(pp)


every_fitness(solver)
# params(solver)
# selection = tourney(solver, 2)
for i in 1:1000
	selection = [Pair(1,2), Pair(3,4), Pair(5,6), Pair(7,8), Pair(9,10)]
	one_point_crossover(solver, selection)
	gaussian(solver)
end
params(solver)