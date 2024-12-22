using Test
using SpectralDeferredCorrections

@testset "Test ConvergenceError" begin
    e = ConvergenceError("Numerical method does not converge after maximum number of iterations.")

    io = IOBuffer()
    Base.showerror(io, e)
    exception_message = String(take!(io))

    @test exception_message ==
          "Numerical method does not converge after maximum number of iterations."

    # Test the error when thrown in a try-catch block
    try
        throw(e)
    catch err
        @test isa(err, ConvergenceError)
        @test err.msg ==
              "Numerical method does not converge after maximum number of iterations."
    end
end

@testset "Test NotImplementedError" begin
    e = NotImplementedError("Not implemented!")

    io = IOBuffer()
    Base.showerror(io, e)
    exception_message = String(take!(io))

    @test exception_message == "Not implemented!"

    try
        throw(e)
    catch err
        @test isa(err, NotImplementedError)
        @test err.msg == "Not implemented!"
    end
end
