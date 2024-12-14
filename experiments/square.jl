include("../src/config.jl")

config = Config(
    Square(40, 0.3),
    Square5x5(40, 0.3),
    SmallBD,
)

script_path = dirname(@__FILE__)
run(config, "$script_path/output")