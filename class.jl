mutable struct ga
	cx
	mr
	elitist
	population
	next_population
	fitness # every fitness
	total_fitness
	ga(pp) = new(0.96, 0.03, [], pp, [], [], 0)
	ga(cx, mr, pp) = new(cx, mr, [], pp, [], [], 0)
end