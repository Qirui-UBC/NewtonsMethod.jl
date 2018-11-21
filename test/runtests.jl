using Newtonsmethod
using Test
using LinearAlgebra

# Testing the first function (unit test)
f(x) = x^2-16.0
f′(x) = 2.0*x
@test newtonroot(f,f′;x₀=10.0)[1] ≈ 4.0 atol=0.00001

f(x) = log(x)-1.0
f′(x) = 1/x
@test newtonroot(f,f′;x₀=3.0)[1] ≈ 2.71828182 atol=0.00001

f(x) = exp(x) - 2.5
f′(x) = exp(x)
@test newtonroot(f,f′;x₀=10.0)[1] ≈ 0.9162907318741551 atol=0.00001

# Testing the second function
f(x) = x^2-16.0
@test newtonroot(f;x₀=10.0)[1] ≈ 4.0 atol=0.00001

f(x) = log(x)-1.0
@test newtonroot(f;x₀=3.0)[1] ≈ 2.71828182 atol=0.00001

f(x) = exp(x) - 2.5
@test newtonroot(f;x₀=10.0)[1] ≈ 0.9162907318741551 atol=0.00001

# Testing the BigFloat
f(x) = exp(x) - 2.5
@test newtonroot(f;x₀ = BigFloat(10.0), tolerance = BigFloat(1E-10), maxiter = BigFloat(1000))[1] ≈ 0.9162907318741551 atol=0.00001

# Testing non-convergence
f(x) = x^2+2.0
f′(x) = 2.0*x
@test newtonroot(f,f′;x₀=1.0) == nothing

# Testing maxiter
f(x) = exp(x) - 2.5
a=newtonroot(f;x₀=10.0)[1]
b=newtonroot(f;x₀=10.0,maxiter=5)
@testset "maxiter" begin
    @test a ≈ 0.9162907318741551 atol=0.00001
    @test b == nothing
end;

# Testing tolerance level
g(x) = exp(x) - 2.5
x₁ = newtonroot(g;x₀=10.0)[1]
x₂ = newtonroot(g;x₀=10.0,tolerance=1E-3)[1]
x₃ = newtonroot(g;x₀=10.0,tolerance=1)[1]
@testset "tolerance" begin
    @test norm(g(x₁)) < norm(g(x₂))
    @test norm(g(x₁)) < norm(g(x₃))
    @test norm(g(x₂)) < norm(g(x₃))
end;

# Give a fail test
g(x) = exp(x) - 2.5
@test newtonroot(g;x₀=1.0) == 1.0
