export HeavyHexTwoLoops

struct HeavyHexTwoLoops <: AbstractSVCircuit
    time_steps::Int
    theta::Float64
end

function Utils.to_container(circ::HeavyHexTwoLoops)
    Dict(:HeavyHexTwoLoops => Dict(:time_steps => circ.time_steps, :theta => circ.theta))
end

get_qubits_number(::AbstractSVCircuit) = 21

function get_specification(circ::HeavyHexTwoLoops)::Vector{Op}
    spec = []
    qubits_number = get_qubits_number(circ)
    for _ in 1:circ.time_steps
        push!(spec, GetDensity(11))
        for pos in 1:qubits_number
            push!(spec, ApplyOneQubitGate(Mixing(-(circ.theta / 2)), pos))
        end
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 2))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 2, 3))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 4))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 4, 5))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 21))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 1, 6))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 5, 7))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 6, 8))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 7, 12))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 8, 9))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 9, 10))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 11))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 11, 12))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 12, 13))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 13, 14))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 8))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 10, 15))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 14, 16))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 15, 17))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 16, 21))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 17, 18))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 18, 19))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 19, 20))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 20, 21))
        push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), 3, 19))
    end
    push!(spec, GetDensity(11))
end