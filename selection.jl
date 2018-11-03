include("class.jl")

function tourney(solver::ga, x)
	selected = []
	rng = MersenneTwisters.MT19937()
	for i in 1:length(solver.population) / 2
		s = []
		for j in 1:2
			picks = sample(rng, 1:length(solver.population), x, replace = false)
			candidates = [(solver.fitness[i], i) for i in picks]
			sort!(candidates)
			# if min
			# push!(s, candidates[1][2])
			# else 
			push!(s, candidates[length(candidates) - 1][2])
		end
		push!(selected, (s[1], s[2]))
	end
	return selected
end