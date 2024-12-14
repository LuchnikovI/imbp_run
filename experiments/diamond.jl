include("../src/config.jl")

config = Config(
    Diamond(40, 0.3),
    DiamondFourLoops(40, 0.3),
    SmallBD,
)

script_path = dirname(@__FILE__)
run(config, "$script_path/output")