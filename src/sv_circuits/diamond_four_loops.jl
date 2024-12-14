export DiamondFourLoops

struct DiamondFourLoops <: AbstractSVCircuit
    time_steps::Int
    theta::Float64
end

function Utils.to_container(circ::DiamondFourLoops)
    Dict(:DiamondFourLoops => Dict(:time_steps => circ.time_steps, :theta => circ.theta))
end

get_qubits_number(::AbstractSVCircuit) = 20

function get_specification(circ::DiamondFourLoops)::Vector{Op}
    spec = []
    qubits_number = get_qubits_number(circ)
    for _ in 1:circ.time_steps
        push!(spec, GetDensity(10))
        for pos in 1:qubits_number
            push!(spec, ApplyOneQubitGate(Mixing(-(circ.theta / 2)), pos))
        end
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 2))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 3))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 4))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 1))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 2))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 9, 10))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 11, 12))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 6))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 8))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 13, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 15, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 6))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 6, 7))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 7, 8))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 8, 5))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 13, 14))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 15))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 15, 16))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 16, 13))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 18))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 17, 18))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 18, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 19, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 20, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 5))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 14))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 7, 4))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 7, 16))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 16, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 6, 15))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 18))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 13, 8))
    end
    push!(spec, GetDensity(10))
end