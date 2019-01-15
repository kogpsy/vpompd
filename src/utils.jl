function cupula_dynamics(τ::Real, Δt::Real)
    τ = 4 # same as Laurens & Angelaki (2017)
    κ₁ = τ / (τ + Δt)
    κ₂ = Δt / (τ + Δt)
    return κ₁, κ₂
end

function velocity(D::Number, A::Number, f::Number, t::Number, start::Number)
    D * A * 1/(2*π*f) * (1-cos.(2*π*f*(t-start)))
end

function acceleration(D::Number, A::Number, f::Number, t::Number, start::Number)
    D * A * sin.(2*π*f*(t-start))
end
