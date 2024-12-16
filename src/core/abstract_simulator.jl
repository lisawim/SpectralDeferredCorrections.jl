module AbstractSimulation

using ..Errors

export AbstractSimulator, run_simulation, iterate, check_convergence


abstract type AbstractSimulator end

function run_simulation(simulator::AbstractSimulator)
    throw(NotImplementedError("run function is not implemented!"))
end

function iterate(simulator::AbstractSimulator)
    throw(NotImplementedError("iterate function is not implemented!"))
end

function check_convergence(simulator::AbstractSimulator)
    throw(NotImplementedError("check_convergence routine is not implemented"))
end
    
end