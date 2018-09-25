using DelimitedFiles, StatsBase, RandomNumbers, Distributions
include("class.jl")
include("selection.jl")
include("crossover.jl")
# include("ga.jl") --> Benchmark
# https://docs.julialang.org/en/v1/manual/constructors/

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
	f = 0.0
	f += w[ind[length(ind)], ind[1]] # ultimo -> primeiro
	for i in 1:length(ind) - 1
		f += w[ind[i], ind[i+1]]
	end
	return f
end

function print_graph(graph)
	for i = 1:length(graph)
		println(graph[i,:])	
	end
end

function random_solve(size)
    return sample(1:size, size, replace = false)
end

function fitness(ind)
	value = w[ind[10], ind[1]]
	for i in 1:length(ind) - 1
		value += w[ind[i], ind[i+1]]
	end
	return value
end

file = "in"
pop_sz = 10
global w = readdlm(file, Int)
# print_graph(w)

pp = [random_solve(10) for x in 1:pop_sz]
cx = 0.96
mr = 0.03

solver = ga(cx, mr, pp)
# solver = ga(pp)

every_fitness(solver)
params(solver)
selection = tourney(solver, 3)
one_point_crossover(solver, selection)
println(solver.next_population)