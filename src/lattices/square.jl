export Square

struct Square <: AbstractLattice
    time_steps::Int
    theta::Float64
end

function Utils.to_container(lattice::Square)
    Dict(:Square => Dict(:time_steps => lattice.time_steps, :theta => lattice.theta))
end

function get_specification(lc::Square)
    LatticeSpecification(
        [SpinUp() for _ in 1:4],                                           # initial state
        [[Mixing(-(lc.theta / 2)) for _ in 1:lc.time_steps] for _ in 1:4], # one-qubit gates
        [[ZZInteraction(pi / 4) for _ in 1:lc.time_steps] for _ in 1:8],   # two-qubit gates
        [(1, 2), (3, 4), (1, 3), (2, 4), (2, 1), (4, 3), (3, 1), (4, 2)],  # layout
        1,                                                                 # target qubit whose dynamics is simulated
    )
end