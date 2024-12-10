module Errors

export NotImplementedError

# Define a custom NotImplementedError
struct NotImplementedError <: Exception
    msg::String
end

# Customize the error message display
Base.showerror(io::IO, e::NotImplementedError) = print(io, e.msg)

end
