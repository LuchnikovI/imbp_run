module Lattices

using IMBP
using ..Utils
using ..Gates
using ..States

export AbstractLattice, build_lattice, get_target_qubit

abstract type AbstractLattice end

struct LatticeSpecification
    initial_states::Vector{AbstractState}
    one_qubit_gates::Vector{Vector{AbstractOneQubitGate}}
    two_qubit_gates::Vector{Vector{AbstractTwoQubitGate}}
    two_qubit_gate_sequence::Vector{Tuple{Int, Int}}
    target_qubit::Int
end

get_specification(::AbstractLattice)::LatticeSpecification = error("Not Yet Implemented")

function Utils.to_container(lc::AbstractLattice)
    spec = get_specification(lc)
    Dict(
        :initial_states => map(Utils.to_container, spec.initial_states),
        :one_qubit_gates => map(x -> map(Utils.to_container, x), spec.one_qubit_gates),
        :two_qubit_gates => map(x -> map(Utils.to_container, x), spec.two_qubit_gates),
        :two_qubit_gate_sequence => spec.two_qubit_gate_sequence,
        :target_qubit => spec.target_qubit,
    )
end

function build_lattice(lattice::AbstractLattice)
    spec = get_specification(lattice)::LatticeSpecification
    lc = LatticeCell(map(get_state_array, spec.initial_states))
    for (pos, gate) in enumerate(spec.one_qubit_gates)
        add_one_qubit_gates!(lc, pos, map(get_channel_array, gate))
    end
    for (poss, gate) in zip(spec.two_qubit_gate_sequence, spec.two_qubit_gates)
        add_two_qubit_gates!(lc, poss[1], poss[2], map(get_channel_array, gate))
    end
    lc
end

get_target_qubit(lattice::AbstractLattice) = get_specification(lattice).target_qubit

include.(filter(contains(r".jl$"), readdir(dirname(@__FILE__) * "/lattices"; join=true)))

end