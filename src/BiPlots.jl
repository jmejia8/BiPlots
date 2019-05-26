module BiPlots

using Bilevel
using Reexport
@reexport using Plots
import Plots: scatter, scatter!, @layout, plot


export scatterPopulation, animateConvergence

include("scatter.jl")



end # module
