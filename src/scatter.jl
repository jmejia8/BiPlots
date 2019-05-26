using Bilevel
import Plots: scatter, scatter!, savefig, @layout, plot, plot!

function populationToMatrix(pop)
    X = zeros(length(pop), length(pop[1].x))
    Y = zeros(length(pop), length(pop[1].y))
    F = zeros(length(pop))
    f = zeros(length(pop))
    
    for i = 1:length(pop)
        X[:,i] = pop[i].x
        X[:,i] = pop[i].y
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
    p = plot(title="Population plot", layout=l)
    

    scatter!(p[1], X[:,1], X[:,2]; xlabel="x_1", ylabel="x_2")
    scatter!(p[2], Y[:,1], Y[:,2]; xlabel="y_1", ylabel="y_2")
    scatter!(p[3], X[:,1], Y[:,1]; xlabel="x_1", ylabel="y_1")
    scatter!(p[4], X[:,2], Y[:,2]; xlabel="x_2", ylabel="y_2")

    p

end

function test()
    c = [Bilevel.generateChild(rand(10), rand(10), 1.0i, 2.0i) for i = 1:10]

    p = scatter(c[1])
    savefig(p, "tmp.png")

    p =  scatter(c)
    savefig(p, "tmp2.png")
end

test()