include("utils.jl")
include("states.jl")
include("gates.jl")
include("lattices.jl")
include("sv_circuits.jl")
include("im_parameters.jl")

using Random
using Dates
using YAML
using Serialization
using IMBP
using NPZ
using .Utils
using .Lattices
using .SVCircuits
using .IMParameters

mutable struct CheckPoint
    config
    iter_number::Int
    info::IMBP.InfoCell
    lattice_cell::LatticeCell
    equations::IMBP.Equations
    influence_matrices
end

function update!(
    ::Nothing,
    config,
    iter_number::Int,
    info::IMBP.InfoCell,
    lattice_cell::LatticeCell,
    equations::IMBP.Equations,
    influence_matrices,
)
    CheckPoint(
        config,
        iter_number,
        info,
        lattice_cell,
        equations,
        influence_matrices,
    )
end

function update!(
    check_point::CheckPoint,
    ::Any,
    iter_number::Int,
    info::IMBP.InfoCell,
    ::LatticeCell,
    ::IMBP.Equations,
    influence_matrices,
)
    check_point.iter_number = iter_number
    check_point.info = info
    check_point.influence_matrices = influence_matrices
    check_point
end

struct Config
    lattice::AbstractLattice
    sv_circuit::Union{AbstractSVCircuit, Nothing}
    im_parameters::Parameters
end

function Utils.to_container(config::Config)
    Dict(
        :lattice => Utils.to_container(config.lattice),
        :sv_circuit => Utils.to_container(config.sv_circuit),
        :im_parameters => Utils.to_container(config.im_parameters),
    )
end

function run(
    config::Config,
    output_path::String,
)
    timestamp = now()
    check_point = nothing
    output_path = "$output_path/$timestamp"
    mkdir(output_path)
    open("$output_path/config.yaml", "w") do io
        YAML.write(io, to_container(config))
        YAML.write(stdout, to_container(config))
        println(stdout, "")
    end
    rng = MersenneTwister(config.im_parameters.seed)
    lc = build_lattice(config.lattice)
    equations = get_equations(lc)
    ims = initialize_ims(config.im_parameters.im_type, lc)
    info = iterate_equations!(
        equations,
        ims,
        config.im_parameters.bond_dimension,
        (iter_num, info, ims) -> begin
            println("Iteration number: ", iter_num)
            println(info)
            print('\n')
            check_point = update!(check_point, config, iter_num, info, lc, equations, ims)
            open("$output_path/check_point", "w+") do io
                serialize(io, check_point)
            end
        end;
        rng=rng,
        sample_size=config.im_parameters.samples_number,
    )
    imbp_density_matrices = simulate_dynamics(
        get_target_qubit(config.lattice),
        equations,
        ims,
    )
    npzwrite("$output_path/imbp_density_matrices.npy", vcat(map(x -> reshape(x, (1, size(x)...)), imbp_density_matrices)...))
    sv_density_matrices = run_circuit(config.sv_circuit)
    npzwrite("$output_path/sv_density_matrices.npy", vcat(map(x -> reshape(x, (1, size(x)...)), sv_density_matrices)...))
end
