using Newtonsmethod
using Test

# Testing the first function (unit test)
f(x) = x^2-16.0
f′(x) = 2.0*x
@test newtonroot(f,f′;x₀=10.0)[1] ≈ 4.0 atol=0.00001

f(x) = log(x)-1.0
f′(x) = 1/x
@test newtonroot(f,f′;x₀=10.0)[1] ≈ 2.71828182 atol=0.00001

f(x) = exp(x) - 2.5
f′(x) = exp(x)
@test newtonroot(f,f′;x₀=10.0)[1] ≈ 0.9162907318741551 atol=0.00001

# Testing the second function
f(x) = x^2-16.0
@test newtonroot(f;x₀=10.0)[1] ≈ 4.0 atol=0.00001

f(x) = log(x)-1.0
@test newtonroot(f;x₀=10.0)[1] ≈ 2.71828182 atol=0.00001

f(x) = exp(x) - 2.5
@test newtonroot(f;x₀=10.0)[1] ≈ 0.9162907318741551 atol=0.00001

# Testing the BigFloat


# Testing non-convergence
f(x) = x^2+2.0
f′(x) = 2.0*x
@test newtonroot(f,f′;x₀=1.0)[1] == nothing

# Testing maxiter
f(x) = exp(x) - 2.5
a=newtonroot(f;x₀=100.0)[1]
b=newtonroot(f;x₀=100.0,maxiter=5)
@testset "maxiter" begin
    @test a ≈ 0.9162907318741551 atol=0.00001\
    @test b = nothing
end;

# Testing tolerance level
f(x) = exp(x) - 2.5
x₁ = newtonroot(f;x₀=100.0)[1]
x₂ = newtonroot(f;x₀=100.0,tolerance=1E-3)[1]
x₃ = newtonroot(f;x₀=100.0,tolerance=1)[1]
@test "tolerance" begin
    @test norm(f(x₁)) < norm(f(x₂))
    @test norm(f(x₁)) < norm(f(x₃))
    @test norm(f(x₂)) < norm(f(x₃))
end;
