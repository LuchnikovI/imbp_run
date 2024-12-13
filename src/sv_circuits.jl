module SVCircuits

using IMBP
using ..Gates
using ..States

export AbstractSVCircuit, run_circuit

using ..Utils

abstract type Op end

apply!(::Op, qs::ExactSim.QSim, state_buffer::Vector{Matrix{ComplexF64}}) = error("Not Yet Implemented")

struct GetDensity <: Op
    position::Int
end

Utils.to_container(get_density::GetDensity) = Dict(:get_density => Dict(:position => get_density.position))

apply!(
    op::GetDensity,
    qs::ExactSim.QSim,
    state_buffer::Vector{Matrix{ComplexF64}},
) = push!(state_buffer, ExactSim.get_one_qubit_dens(qs, op.position))

struct ApplyOneQubitGate <: Op
    gate::AbstractOneQubitGate
    position::Int
end

function Utils.to_container(apply_one_qubit_gate::ApplyOneQubitGate)
    gate_container = Utils.to_container(apply_one_qubit_gate.gate)
    Dict(:apply_one_qubit_gate => Dict(
        :position => apply_one_qubit_gate.position,
        :gate => gate_container,
    ))
end

apply!(
    op::ApplyOneQubitGate,
    qs::ExactSim.QSim,
    ::Vector{Matrix{ComplexF64}},
) = ExactSim.apply_one_qubit_gate!(qs, get_gate_array(op.gate), op.position)

struct ApplyTwoQubitGate <: Op
    gate::AbstractTwoQubitGate
    first_position::Int
    second_position::Int
end

function Utils.to_container(apply_two_qubit_gate::ApplyTwoQubitGate)
    gate_container = Utils.to_container(apply_two_qubit_gate.gate)
    Dict(:apply_two_qubit_gate => Dict(
        :first_position => apply_two_qubit_gate.first_position,
        :second_position => apply_two_qubit_gate.second_position,
        :gate => gate_container,
    ))
end

apply!(
    op::ApplyTwoQubitGate,
    qs::ExactSim.QSim,
    ::Vector{Matrix{ComplexF64}},
) = ExactSim.apply_two_qubit_gate!(qs, get_gate_array(op.gate), op.first_position, op.second_position)

abstract type AbstractSVCircuit end

get_specification(::AbstractSVCircuit)::Vector{Op} = error("Not Yet Implemented")
get_qubits_number(::AbstractSVCircuit) = error("Not Yet Implemented")

function Utils.to_container(circ::AbstractSVCircuit)
    spec = get_specification(circ)
    map(Utils.to_container, spec)
end

function run_circuit(circuit::AbstractSVCircuit)
    qs = ExactSim.QSim(Float64, get_qubits_number(circuit))
    result = Matrix{ComplexF64}[]
    for op in get_specification(circuit)
        apply!(op, qs, result)
    end
    result
end
run_circuit(::Nothing) = nothing

include.(filter(contains(r".jl$"), readdir(dirname(@__FILE__) * "/sv_circuits"; join=true)))

end