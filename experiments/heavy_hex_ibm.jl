include("../src/config.jl")

config = Config(
    HeavyHexIBM(40, 0.6),
    HeavyHexTwoLoops(40, 0.6),
    LargeBD,
)

script_path = dirname(@__FILE__)
run(config, "$script_path/output")