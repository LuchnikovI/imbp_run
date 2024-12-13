export MidBD

const MidBD = Parameters(
    64,                              # bond dimension
    42,                              # seed
    25,                              # number of samples to estimate discrepancy
    SketchyIM{Array{ComplexF64, 4}}, # IM type
)