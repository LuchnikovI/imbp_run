module Gates

using ..Utils

export AbstractOneQubitGate, AbstractTwoQubitGate, get_channel_array, get_gate_array

abstract type AbstractGate end

get_gate_array(::AbstractGate) = error("Not Yet Implemented")

function get_channel_array(gate::AbstractGate)
    gate_array = get_gate_array(gate)::Matrix{ComplexF64}
    kron(gate_array, conj(gate_array))
end

abstract type AbstractOneQubitGate <: AbstractGate end

abstract type AbstractTwoQubitGate <: AbstractGate end

include.(filter(contains(r".jl$"), readdir(dirname(@__FILE__) * "/gates"; join=true)))

end
