function populationToMatrix(pop)
    X = zeros(length(pop), length(pop[1].x))
    Y = zeros(length(pop), length(pop[1].y))
    F = zeros(length(pop))
    f = zeros(length(pop))
    
    for i = 1:length(pop)
        X[i,:] = pop[i].x
        Y[i,:] = pop[i].y
        f[i] = pop[i].f
        F[i] = pop[i].F
    end

    return X, Y, F, f
end

function scatter(indiv::Bilevel.xf_indiv; kargs...)
    scatter([indiv.x[1]], [indiv.x[1]]; kargs...)
end

function scatter!(indiv::Bilevel.xf_indiv; kargs...)
    scatter!([indiv.x[1]], [indiv.x[1]]; kargs...)
end

function scatter(population::Array{Bilevel.xf_indiv}; kargs...)
    X, Y, F, f = populationToMatrix(population)

    l = @layout [a b ; c d]
    p = plot(layout=l; kargs...)
    

    scatter!(p[1], X[:,1], X[:,2]; xlabel="x_1", ylabel="x_2")
    scatter!(p[2], Y[:,1], Y[:,2]; xlabel="y_1", ylabel="y_2")
    scatter!(p[3], X[:,1], Y[:,1]; xlabel="x_1", ylabel="y_1")
    scatter!(p[4], X[:,2], Y[:,2]; xlabel="x_2", ylabel="y_2")

    p

end

function plot(status::Bilevel.State, l = @layout [a b]; kargs...)
    X, Y, F, f = populationToMatrix(status.population)
    
    p = plot(layout=l; kargs...)
    scatter!(p[1], X[:,1], X[:,2]; xlabel="x_1", ylabel="x_2")
    scatter!(p[2], Y[:,1], Y[:,2]; xlabel="y_1", ylabel="y_2")
    
    scatter!(p[1],status.best_sol.x[1:1], status.best_sol.x[2:2]; markercolor=:red)
    scatter!(p[2],status.best_sol.y[1:1], status.best_sol.y[2:2]; markercolor=:red)

    return p

end

function animateConvergence(convergence::Array{Bilevel.State}; kargs...)
    F = [ s.best_sol.F for s in convergence ]
    f = [ s.best_sol.f for s in convergence ]

    ul_evals = [ s.F_calls for s in convergence ]
    ll_evals = [ s.f_calls for s in convergence ]

    a = @animate for t = 1:length(convergence)
        l = @layout [a b; c d]
        p = plot(convergence[t], l; kargs...)

        plot!(p[3], ul_evals[1:t], F[1:t],
            title="UL convergence",
            xlim=[ minimum(ul_evals), maximum(ul_evals)],
            ylim=[ minimum(F), maximum(F)],
            xlabel="UL FEs",
            ylabel="UL Error",
            )
        
        plot!(p[4], ll_evals[1:t], f[1:t],
            title="LL convergence",
            xlim=[ minimum(ll_evals), maximum(ll_evals)],
            ylim=[ minimum(f), maximum(f)],
            xlabel="LL FEs",
            ylabel="LL Error",
            )
    end
    
    return a
end
