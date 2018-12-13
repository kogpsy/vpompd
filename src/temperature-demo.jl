using Random, Distributions, Turing, Plots

σ_true = 1 # true standard deviation of measurement device
temperature = 21.0 # true temperature

# we take 100 measurements of the temperature
measurements = rand(Normal(temperature, σ_true), 100)

histogram(measurements)

#=
prior on temperature: I'm about 95% certain that the temperature will
lie between -40 and +40, i.e. 95% of the distribution lies between μ-2σ and  μ+2σ
=#
temperature_prior = Normal(0, 20)
plot(x -> pdf(temperature_prior, x), -100, 100)
xlabel!("Prior belief about temperature")

# inference model
@model infer_temperture(y) = begin
    N = length(y)
    # prior on measurement noise
    σ ~ Truncated(Cauchy(0, 2), 0, Inf)
    # prior on temperature
    temperature ~ Normal(0, 20)

    # observations
    for i ∈ 1:N
        y[i] ~ Normal(temperature, σ)
    end
end

temp_samples = sample(infer_temperture(measurements), SMC(300))

mean(temp_samples[:temperature])
