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

solver = ga(pp)
println(solver)