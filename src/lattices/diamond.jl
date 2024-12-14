export Diamond

struct Diamond <: AbstractLattice
    time_steps::Int
    theta::Float64
end

function Utils.to_container(lattice::Diamond)
    Dict(:Diamond => Dict(:time_steps => lattice.time_steps, :theta => lattice.theta))
end

function get_specification(lc::Diamond)
    LatticeSpecification(
        [SpinUp() for _ in 1:2],                                           # initial state
        [[Mixing(-(lc.theta / 2)) for _ in 1:lc.time_steps] for _ in 1:2], # one-qubit gates
        [[ZZInteraction(pi / 4) for _ in 1:lc.time_steps] for _ in 1:4],   # two-qubit gates
        [(1, 2), (1, 2), (1, 2), (1, 2)],                                  # layout
        1,                                                                 # target qubit whose dynamics is simulated
    )
end