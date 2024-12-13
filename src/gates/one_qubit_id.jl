export OneQubitID

struct OneQubitID <: AbstractOneQubitGate end

get_gate_array(::OneQubitID) = ComplexF64[1 0 ; 0 1]
Utils.to_container(::OneQubitID) = :one_qubit_id