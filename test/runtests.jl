using BiPlots
using Bilevel
using Test

function test1()
    c = [Bilevel.generateChild(rand(10), rand(10), 1.0i, 2.0i) for i = 1:10]

    p = scatter(c[1])
    savefig(p, "tmp.png")

    p = scatter(c)
    savefig(p, "tmp2.png")

    true
end

@test test1()