export ZZInteraction

struct ZZInteraction <: AbstractTwoQubitGate
    ampl::Float64
end

get_gate_array(gate::ZZInteraction) = exp(im * gate.ampl * ComplexF64[1 0 0 0 ; 0 -1 0 0 ; 0 0 -1 0 ; 0 0 0 1])
Utils.to_container(gate::ZZInteraction) = Dict(:zz_interaction => Dict(:ampl => gate.ampl))