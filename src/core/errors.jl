module Errors

export ConvergenceError, NotImplementedError, ParameterError

struct ConvergenceError <: Exception
    msg::String
end
Base.showerror(io::IO, e::ConvergenceError) = print(io, e.msg)

struct NotImplementedError <: Exception
    msg::String
end
Base.showerror(io::IO, e::NotImplementedError) = print(io, e.msg)

struct ParameterError <: Exception
    msg::String
end
Base.showerror(io::IO, e::ParameterError) = print(io, e.msg)

end
