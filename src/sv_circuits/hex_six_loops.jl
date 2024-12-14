export HexSixLoops

struct HexSixLoops <: AbstractSVCircuit
    time_steps::Int
    theta::Float64
end

function Utils.to_container(circ::HexSixLoops)
    Dict(:HexSixLoops => Dict(:time_steps => circ.time_steps, :theta => circ.theta))
end

get_qubits_number(::AbstractSVCircuit) = 22

function get_specification(circ::HexSixLoops)::Vector{Op}
    spec = []
    qubits_number = get_qubits_number(circ)
    for _ in 1:circ.time_steps
        push!(spec, GetDensity(12))
        for pos in 1:qubits_number
            push!(spec, ApplyOneQubitGate(Mixing(-(circ.theta / 2)), pos))
        end
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 2))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 3))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 22))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 5))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 7))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 5))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 6))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 6, 7))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 7, 8))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 8, 15))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 6, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 8, 13))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 9, 10))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 11, 12))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 13))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 13, 14))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 15))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 15, 16))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 16, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 17, 18))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 18, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 16, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 18, 22))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 20, 21))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 21, 22))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 21))
    end
    push!(spec, GetDensity(12))
end