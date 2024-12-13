include("../src/config.jl")

config = Config(
    HeavyHexIBM(10, 0.9),
    HeavyHexThreeLoops(10, 0.9),
    SmallBD,
)

script_path = dirname(@__FILE__)
run(config, "$script_path/output")