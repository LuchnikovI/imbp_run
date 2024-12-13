export HeavyHexThreeLoops

struct HeavyHexThreeLoops <: AbstractSVCircuit
    time_steps::Int
    theta::Float64
end

function Utils.to_container(circ::HeavyHexThreeLoops)
    Dict(:HeavyHexThreeLoops => Dict(:time_steps => circ.time_steps, :theta => circ.theta))
end

get_qubits_number(::AbstractSVCircuit) = 28

function get_specification(circ::HeavyHexThreeLoops)::Vector{Op}
    spec = []
    qubits_number = get_qubits_number(circ)
    for _ in 1:circ.time_steps
        push!(spec, GetDensity(17))
        for pos in 1:qubits_number
            push!(spec, ApplyOneQubitGate(Mixing(-(circ.theta / 2)), pos))
        end
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 2))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 3))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 4))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 5))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 6))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 6, 7))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 7, 8))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 8, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 10))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 9, 12))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 13))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 11, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 21))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 13, 14))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 15))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 15, 16))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 16, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 17, 18))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 18, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 19, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 20, 21))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 15, 22))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 19, 23))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 22, 24))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 23, 28))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 24, 25))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 25, 26))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 26, 27))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 27, 28))
    end
    push!(spec, GetDensity(17))
end