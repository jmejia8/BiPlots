# BiPlots

Plot results of Bilevel package.

## Example

Import necessary packages:
```julia
using Bilevel
using BiPlots
```

Definition of the bilevel optimization problem:


```julia
# minimize
F(x,y) = sum((x + y - sin.(4π*x)).^2)

# subject to: y in arg min f(x,y) with
f(x,y) = sum((sin.(4π*x) - y).^2)
```

Configure the BCA method:

```julia

options = Options(F_calls_limit=1000,
                    f_calls_limit=Int(1e6),
                    debug=false,store_convergence=false)

BCA = BCAOperators.BCAFW(N =30)

method = Algorithm(BCA;
                    initialize! = BCAOperators.initialize!,
                    update_state! = BCAOperators.update_state!,
                    lower_level_optimizer = BCAOperators.lower_level_optimizer,
                    is_better = BCAOperators.is_better,
                    stop_criteria = BCAOperators.stop_criteria,
                    options = options)

```

Optimize and get results:

```julia
r = optimize(F,
            f,
            [-1 -1; 1 1.0],
            [-1 -1; 1 1.0],
            method
    )
```

Convergence animation:

```julia
a = animateConvergence(Array{State{Int64}}(r.convergence); legend=false) 
gif(a, "tmp1.gif")
```

![animateConvergence](https://bi-level.org/wp-content/uploads/2019/05/tmp1.gif)

Population dynamics:

```julia

a = @animate for t=1:length(r.convergence)
    scatter(r.convergence[t].population; legend=false, title="iter: $t")
end
gif(a, "tmp2.gif")


```

![population dynamics](https://bi-level.org/wp-content/uploads/2019/05/tmp2.gif)
