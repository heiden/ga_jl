include("class.jl")

function gaussian(solver::ga)
	d = Normal(0.0, 0.5) # Normal(μ = 0.0, σ = 0.5), σ = 1.0 also works
	for ind in solver.next_population
		for i in 1:length(ind)
			ω = rand()
			if ω < solver.mr
				ind[i] += rand(d)
			end
		end
	end
	solver.population = solver.next_population
end