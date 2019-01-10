using StatsFuns: logistic
using Plots

βs = [0, 0.2, 0.5, 0.8, 1.0, 1.2, 1.5, 2, 3, 5, 7, 8, 10, 20]

plot([x -> logistic(β * x) for β in βs],
        -2, 2,
        alpha = 0.8,
        legend = :none,
        ylims = [0, 1])
