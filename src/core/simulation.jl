module SimulationBase

using ..Errors

export AbstractSimulator, run_simulation

abstract type AbstractSimulator end

function run_simulation(simulator::AbstractSimulator)
    throw(NotImplementedError("run_simulation function is not implemented!"))
end

end
