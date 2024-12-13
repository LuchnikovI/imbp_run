using IMBP
include("../src/config.jl")

config = Config(
    HeavyHexIBM(10, 0.9),
    HeavyHexThreeLoops(10, 0.9),
    LargeBD,
)

run(config)