export SpinUp

struct SpinUp <: AbstractState end

get_state_array(::SpinUp) = ComplexF64[1 0 ; 0 0]
Utils.to_container(::SpinUp) = :spin_up