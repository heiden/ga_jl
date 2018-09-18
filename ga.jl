using DelimitedFiles, StatsBase, BenchmarkTools
# include("ga.jl") --> Benchmark
# https://docs.julialang.org/en/v1/manual/constructors/

mutable struct ga
	cx
	mr
	elitist
	population
	next_population
	fitness # every fitness
	total_fitness
	ga(pp) = new(0.96, 0.03, [], pp, [[] for x in 1:length(pp[1])], [0 for x in 1:length(pp)], 0)
	ga(cx, mr, pp) = new(cx, mr, [], pp, [[] for x in 1:length(pp[1])], [0 for x in 1:length(pp)], 0)

end

function params(solver::ga)
	println("Cx: ", solver.cx)
	println("Mr: ", solver.mr)
	println("Elitist: ", solver.elitist)
	println("Population + Fitness:")
	for i in 1:size(solver.fitness, 1)
		println(solver.population[i], " : " , solver.fitness[i])
	end
	println("Fitness: ", solver.fitness)
	println("Total fitness: ", solver.total_fitness)
end

function every_fitness(solver::ga)
	fs = []
	tf = 0.0
	for ind in solver.population
		f = calc_fitness(ind)
		tf += f
		append!(fs, f)
	end
	solver.fitness = fs
	solver.total_fitness = tf
end

function calc_fitness(ind)
	f = 0.0
	f += w[ind[size(ind, 1)], ind[1]] # ultimo -> primeiro
	for i in 1:size(ind, 1) - 1
		f += w[ind[i], ind[i+1]]
	end
	return f
end

function print_graph(graph)
	for i = 1:size(graph, 1)
		println(graph[i,:])	
	end
end

function random_solve(size)
    return sample(1:size, size, replace = false)
end

function fitness(ind)
	value = w[ind[10], ind[1]]
	for i in 1:size(ind, 1) - 1
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

params(solver)
every_fitness(solver)
params(solver)
