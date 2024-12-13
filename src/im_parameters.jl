module IMParameters

using IMBP
using ..Utils

export Parameters

struct Parameters
    bond_dimension::Int
    seed::Int
    samples_number::Int
    im_type::Union{Type{IMBP.IM{Array{ComplexF64, 4}}}, Type{IMBP.SketchyIM{Array{ComplexF64, 4}}}}
end

function Utils.to_container(params::Parameters)
    Dict(
        :bond_dimension => params.bond_dimension,
        :seed => params.seed,
        :samples_number => params.samples_number,
        :im_type => isa(params.im_type, Type{SketchyIM{T}} where T) ? "SketchyIM" : isa(params.im_type, Type{SketchyIM{T}} where T) ? "IM" : error("Unknown type of IM")
    )
end

include.(filter(contains(r".jl$"), readdir(dirname(@__FILE__) * "/im_parameters"; join=true)))

end