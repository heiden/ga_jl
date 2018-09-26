using DelimitedFiles, StatsBase, RandomNumbers, Distributions
include("class.jl"), include("selection.jl"), include("crossover.jl"), include("mutation.jl")

# include("ga.jl") --> Benchmark

function params(solver::ga)
	println("Cx: ", solver.cx)
	println("Mr: ", solver.mr)
	println("Bounds: [", solver.lb, ", ",solver.ub, "]")
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
		if f < solver.elitist[2]
			solver.elitist = Pair(ind, f)
		end
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

function reset_aux(solver::ga)
	solver.next_population = []
	solver.fitness = []
	solver.total_fitness = 0
end

file = "ackley.in"
dim, pop_sz, cx, mr, lb, ub = scan_ackley(file)
# global w = readdlm(file, Int)
# print_graph(w)

pp = [random_solve(dim, lb, ub) for x in 1:pop_sz]

solver = ga(cx, mr, lb, ub, pp)

# params(solver)
for i in 1:3000
	every_fitness(solver)
	selection = tourney(solver, 2)
	one_point_crossover(solver, selection)
	gaussian(solver)
	reset_aux(solver)
	println(i, " ", solver.elitist[2])	
end
# println(solver.elitist)