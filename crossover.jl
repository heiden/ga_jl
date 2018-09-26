include("class.jl")

function one_point_crossover(solver::ga, selected)
	rng = MersenneTwisters.MT19937()
	for s in selected
		oa, ob = [], []
		ia, ib = solver.population[s[1]], solver.population[s[2]]
		p = rand(rng, 1:length(ia))
		append!(oa, ia[1:p]), append!(oa, ib[p+1:length(ib)])
		append!(ob, ib[1:p]), append!(ob, ia[p+1:length(ia)])
		push!(solver.next_population, oa), push!(solver.next_population, ob)
	end
end

function two_point_crossover(solver::ga, selected)
	rng = MersenneTwisters.MT19937()
	for s in selected
		oa, ob = [], []
		ia, ib = solver.population[s[1]], solver.population[s[2]]
		px, py = sort!(rand(rng, 1:length(ia), 2))
		append!(oa, ia[1:px-1]), append!(oa, ib[px:py]), append!(oa, ia[py+1:length(ia)])
		append!(ob, ib[1:px-1]), append!(ob, ia[px:py]), append!(ob, ib[py+1:length(ib)])
		push!(solver.next_population, oa), push!(solver.next_population, ob)
	end
end