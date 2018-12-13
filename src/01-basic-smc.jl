using Random, Distributions, Turing, Plots

#=
generate data
=#

Δt = 0.1
duration = 4
timesteps = range(0, stop=duration, step=Δt)
T = length(timesteps)
x = zeros(T) # state
y = zeros(T) # observations

σy = 1
σx = 1
x[1] = rand(Normal(0, 1))
y[1] = rand(Normal(x[1], σy))

for t ∈ 2:T
    x[t] = rand(Normal(x[t-1], σx))
    y[t] = rand(Normal(x[t], σy))
end

p_data = plot(timesteps, x, legend = false)
scatter!(p_data, timesteps, y)


#=
inference model
=#

@model smc_model(y) = begin
    N = length(y)
    x = tzeros(Real, N)

    x[1] ~ Normal(0, σx)
    y[1] ~ Normal(x[1], σy)

    for i ∈ 2:N
        x[i] ~ Normal(x[i-1], σx)
        y[i] ~ Normal(x[i], σy)
    end
end

posterior = sample(smc_model(y), SMC(1000))

plot!(p_data, timesteps, posterior[:x], alpha = 0.01)
