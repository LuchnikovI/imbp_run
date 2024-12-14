export Square5x5

struct Square5x5 <: AbstractSVCircuit
    time_steps::Int
    theta::Float64
end

function Utils.to_container(circ::Square5x5)
    Dict(:Square5x5 => Dict(:time_steps => circ.time_steps, :theta => circ.theta))
end

get_qubits_number(::AbstractSVCircuit) = 25

coord_to_number(row::Int, col::Int) = 5 * (row - 1) + col

function get_specification(circ::Square5x5)::Vector{Op}
    spec = []
    qubits_number = get_qubits_number(circ)
    for _ in 1:circ.time_steps
        push!(spec, GetDensity(13))
        for pos in 1:qubits_number
            push!(spec, ApplyOneQubitGate(Mixing(-(circ.theta / 2)), pos))
        end
        for row in 1:5
            for col in 1:5
                end_row = row + 1 > 5 ? 1 : row + 1
                end_col = col + 1 > 5 ? 1 : col + 1
                push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), coord_to_number(row, col), coord_to_number(row, end_col)))
                push!(spec, ApplyTwoQubitGate(ZZInteraction(pi / 4), coord_to_number(row, col), coord_to_number(end_row, col)))
            end
        end
    end
    push!(spec, GetDensity(13))
end