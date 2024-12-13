module States

export AbstractState, get_state_array

using ..Utils

abstract type AbstractState end

get_state_array(::AbstractState) = error("Not Yet Implemented")

include.(filter(contains(r".jl$"), readdir(dirname(@__FILE__) * "/states"; join=true)))

end