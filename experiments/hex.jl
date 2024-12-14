include("../src/config.jl")

config = Config(
    Hex(40, 0.6),
    HexSixLoops(40, 0.6),
    LargeBD,
)

script_path = dirname(@__FILE__)
run(config, "$script_path/output")