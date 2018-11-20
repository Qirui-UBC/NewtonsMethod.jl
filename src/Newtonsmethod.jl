module Newtonsmethod

greet() = print("Hello World!")

using Expectations, Distributions, ForwardDiff, LinearAlgebra

function Newtonsmethod(f, f', x_0, tolerance = 1E-7, maxiter = 1000)
    # setup the algorithm
    x_old = x_0
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = x_old - f(x_old)/f'(x_old)
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (value = x_old, normdiff = normdiff, iter = iter)
end

function Newtonsmethod(f, x_0, tolerance = 1E-7, maxiter = 1000)
    D(f) = x -> ForwardDiff.derivative(f, x)
    f_prime = D(f)
    x_old = x_0
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = x_old - f(x_old)/f_prime(x_old)
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (value = x_old, normdiff = normdiff, iter = iter)
end



end # module
