include("utils.jl")
include("states.jl")
include("gates.jl")
include("lattices.jl")
include("sv_circuits.jl")
include("im_parameters.jl")

using Random
using .Utils
using .Lattices
using .SVCircuits
using .IMParameters
using Plots
using YAML

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

function run(config::Config)
    println(YAML.write(stdout, to_container(config)))
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
            println("Some IMs parameters:")
            for (key, val) in ims
                println("\t", key, ":", "\n\t\ttime steps number: ", get_time_steps_number(val), "\n\t\tbond dimensions: ", get_bond_dimensions(val))
            end
            print('\n')
        end;
        rng=rng,
        sample_size=config.im_parameters.samples_number,
    )
    imbp_density_matrices = simulate_dynamics(
        get_target_qubit(config.lattice),
        equations,
        ims,
    )
    sv_density_matrices = run_circuit(config.sv_circuit)
    imbp_z_dyn = real(map(x -> x[1, 1] - x[2, 2], imbp_density_matrices))
    sv_z_dyn = real(map(x -> x[1, 1] - x[2, 2], sv_density_matrices))
    plot([imbp_z_dyn, sv_z_dyn])
end
