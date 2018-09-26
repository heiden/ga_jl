mutable struct ga
	cx
	mr
	lb
	ub
	elitist
	population
	next_population
	fitness # every fitness
	total_fitness
	ga(lb, ub, pp) = new(0.96, 0.03, lb, ub, Pair([], 1e6), pp, [], [], 0)
	ga(cx, mr, lb, ub, pp) = new(cx, mr, lb, ub, Pair([], 1e6), pp, [], [], 0)
end