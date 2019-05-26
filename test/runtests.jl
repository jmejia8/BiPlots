using BiPlots
using Bilevel
using Test

function test1()
    c = [Bilevel.generateChild(rand(3), randn(3).^2, 1.0i, 2.0i) for i = 1:100]

    p = scatter(c[1])
    # savefig(p, "tmp.png")

    p =  scatter(c; legend=false)
    # savefig(p, "tmp2.png")


    new_pop(t) = [Bilevel.generateChild(rand(3)/t, randn(3)/t, 1.0i, 2.0i) for i = 1:100]
    convergence = [Bilevel.State(c[t], new_pop(1.0t); F_calls=7t + rand(1:100), f_calls=500t + rand(1:400)) for t=1:20]

    p = animateConvergence(convergence; legend=false)
    # gif(p, "tmp.gif")

    true
end

@test test1()