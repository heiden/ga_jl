include("class.jl")

function one_point_crossover(solver::ga, selected)
	rng = MersenneTwisters.MT19937()
	for p in selected
		oa, ob = [], []
		ia, ib = solver.population[p[1]], solver.population[p[2]]
		point = rand(rng, 1:length(solver.population[1]))
		append!(oa, ia[1:point]), append!(oa, ib[point+1:length(ib)])
		append!(ob, ib[1:point]), append!(ob, ia[point+1:length(ia)])
		push!(solver.next_population, oa), push!(solver.next_population, ob)
	end
end