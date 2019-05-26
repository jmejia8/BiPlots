module BiPlots



using Bilevel
using Reexport
@reexport using Plots
import Plots: scatter


export scatterPopulation
export scatter

include("scatter.jl")

# function scatterPopulation(X, Y, F, f)
    

#     l = @layout[a b ; c d]
#     p = scatter(X[:,1], X[:,2], layout=l)

#     scatter!(p[2], Y[:,1], Y[:,2])
#     scatter!(p[3], X[:,1], Y[:,1])
#     scatter!(p[4], X[:,2], Y[:,2])

#     p
# end

end # module
