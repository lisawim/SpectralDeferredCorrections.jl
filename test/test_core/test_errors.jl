using Test
using SpectralDeferredCorrections

@testset "Test ConvergenceError" begin
    err_msg = "Numerical method does not converge after maximum number of iterations."
    e = ConvergenceError(err_msg)

    io = IOBuffer()
    Base.showerror(io, e)
    exception_message = String(take!(io))

    @test exception_message == err_msg

    # Test the error when thrown in a try-catch block
    try
        throw(e)
    catch err
        @test isa(err, ConvergenceError)
        @test err.msg == err_msg
    end
end

@testset "Test NotImplementedError" begin
    err_msg = "Not implemented!"
    e = NotImplementedError(err_msg)

    io = IOBuffer()
    Base.showerror(io, e)
    exception_message = String(take!(io))

    @test exception_message == err_msg

    try
        throw(e)
    catch err
        @test isa(err, NotImplementedError)
        @test err.msg == err_msg
    end
end