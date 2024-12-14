export HeavyHexIBM

struct HeavyHexIBM <: AbstractLattice
    time_steps::Int
    theta::Float64
end

function Utils.to_container(lattice::HeavyHexIBM)
    Dict(:HeavyHexIBM => Dict(:time_steps => lattice.time_steps, :theta => lattice.theta))
end

function get_specification(lc::HeavyHexIBM)
    LatticeSpecification(
        [SpinUp() for _ in 1:5],                                           # initial state
        [[Mixing(-(lc.theta / 2)) for _ in 1:lc.time_steps] for _ in 1:5], # one-qubit gates
        [[ZZInteraction(pi / 4) for _ in 1:lc.time_steps] for _ in 1:6],   # two-qubit gates
        [(1, 2), (4, 5), (2, 4), (5, 3), (2, 3), (1, 5)],                  # layout
        3,                                                                 # target qubit whose dynamics is simulated
    )
end