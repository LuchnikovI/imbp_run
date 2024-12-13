export TwoQubitID

struct TwoQubitID <: AbstractTwoQubitGate end

get_gate_array(::TwoQubitID) = ComplexF64[1 0 0 0 ; 0 1 0 0 ; 0 0 1 0 ; 0 0 0 1]
Utils.to_container(::TwoQubitID) = :two_qubit_id