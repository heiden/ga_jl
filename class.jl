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
	ga(lb, ub, pp) = new(0.96, 0.03, [], lb, ub, pp, [], [], 0)
	ga(cx, mr, lb, ub, pp) = new(cx, mr, [], lb, ub, pp, [], [], 0)
end