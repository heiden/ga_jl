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

function print_graph(w)
	for i = 1:size(w,1)
		println(w[i,:])	
	end
end

file = "in"
global w = readdlm(file, Int)
print_graph(w)

solver = ga([[2,2,3], [2,2,3], [2,2,3]])
println(solver.cx)
solver.elitist = 0
println(solver.elitist)
println(solver.fitness)
println(solver.next_population)