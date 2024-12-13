export Mixing

struct Mixing <: AbstractOneQubitGate
    ampl::Float64
end

get_gate_array(gate::Mixing) = exp(im * gate.ampl * ComplexF64[0 1 ; 1 0])
Utils.to_container(gate::Mixing) = Dict(:mixing => Dict(:ampl => gate.ampl))