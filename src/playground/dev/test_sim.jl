using SpectralDeferredCorrections

eps = 1.0
prob = LinearTestSPP(eps)

sweeper = FullyImplicitSDCSweeper()

t0 = 0.0
dt = 1e-1
Tend = 1.0

restol = 1e-12
maxiter = 1

sim = Simulator(prob, sweeper, t0, dt, Tend, restol, maxiter)

run_simulation(sim)