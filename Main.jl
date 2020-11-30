### Main bits of a game

# Game state structure
# game_state = [
#   [Location, [PieceID, (Already moved, if pawn)]]
# ]

"""
    name(args)

documentation
"""
function name(args)
    body
end

"""
    chSearch(game_state::Array)

Recursive search to find the optimal move.
This MODIFIES game_state so you should pass a deepcopy of game_state.
(The name is not chSearch! because it returns an optimal move not a game_state)
"""
function chSearch(game_state::Array)

    moves = chMoves(game_state)
    for move in moves
        new_state = chMakePlay(game_state, move)
        # If human is in check in the scenario, this is an optimal move
        if chCheck(new_state)[2] == 2

            return move

        else

            # human's turn
            flip_state = deepcopy(new_state)
            chFlip!(flip_state)
            human_moves = chMoves(flip_state)

        end # if
    end # for

end # function

"""
    chMakePlay(game_state::Array, play::Array{Array{Int64, 1}})

This function modifies the game_state for when the computer makes a play.
It can be used to modify the game_state once the optimal move is found.
chMakePlay() uses chTake! so it doesn't need to be used elsewhere.
"""
function chMakePlay(game_state::Array, play::Array{Array{Int64, 1}, 1})

    chTake!(game_state, play[2])

    for piece in game_state

        if piece[1] == play[1]
            piece[1] = play[2]
            break
        end # if

    end # for

    return game_state

end # function

"""
    chResolve(game_state::Array)

This runs one entire turn for the computer.
"""
function chResolve(game_state::Array)

    copy_state = deepcopy(game_state)
    optimal_move = chSearch(copy_state)

    new_state = chMakePlay(game_state, optimal_move)

    return new_state

end # function

"""
    chRunGame(game_state::Array)

This runs the entire game assuming the computer goes first.
chRunGame() takes a game_state so that we can start from any state
(e.g. where the human is white)
"""
function chRunGame(game_state::Array)

    is_alive = true
    while is_alive

        new_state = chResolve(game_state)

        chShowBoard(new_state)

        chPlayHuman!(new_state)

        chShowBoard(new_state)

        game_state = new_state

    end # while

end # function

"""
    chTake!(game_state::Array, loc::Array{Int64, 1})

Remove a piece at a location from the game.
This should be used before updating the game_state with a piece move.
"""
function chTake!(game_state::Array, loc::Array{Int64, 1})

    for piece in range(1, length = length(game_state))
        if game_state[piece][1] == loc
            pop!(game_state, piece)
        end # if
    end # for

end # function

"""
    chCheck(game_state::Array)

--- INCOMPLETE ---
This checks if each player is in check (returns 1), or checkmate (returns 2)
Returns an Array{Int64, 1} containing the state for each player.
E.g. [0 (player 1 not in check), 2 (player 2 checkmate)]
"""
function chCheck(game_state::Array)

    return [0, 0]

end # function

"""
    chFlip!(game_state::Array)

Modifies game_state to be as if player 1 were player 2 with the piece locations flipped vertically.
Deepcopy game_state before running if you wish to preserve the previous state.
"""
function chFlip!(game_state::Array)

    for piece in game_state
        piece[1][2] = 9 - piece[1][2]
        if piece[3] == 1
            piece[3] = 2
        else
            piece[3] = 1
        end # if
    end # for

end # function

"""
    chFlip!(moves::Array{Array{Int64, 1}})

Flips every the vertical element of each move.
"""
function chFlip!(moves::Array{Array{Int64, 1}})

    for move in moves
        move[1][2] = 9 - move[1][2]
        move[2][2] = 9 - move[2][2]
    end # for

end # function

"""
    chMoves(game_state::Array)

Gets all possible valid moves player 1 (on the bottom) can make.
"""
function chMoves(game_state::Array)

    # Different numbers in the piece type indicate pieces
    # 1 -> Pawn - Extra info: Already moved [bool]
    # 2 -> Rook
    # 3 -> Knight
    # 4 -> Bishop
    # 5 -> Queen
    # 6 -> King

    moves = []

    # Get all possible (not necessarily valid moves)

    for piece in game_state

        if piece[3] == 1

            location = piece[1]
            type = piece[2][1]

            if type == 1

                already_moved = piece[2][2]

                push!(moves, [location, [location[1], location[2] + 1]])
                if already_moved == false
                    push!(moves, [location, [location[1], location[2] + 2]])
                end # if

            elseif type == 2

                for i in 1:8
                    push!(moves, [location, [i, location[2]]])
                    push!(moves, [location, [location[1], i]])
                end # for

            elseif type == 3

                push!(moves, [location, [location[1] + 1, location[2] + 2]])
                push!(moves, [location, [location[1] - 1, location[2] + 2]])
                push!(moves, [location, [location[1] + 1, location[2] - 2]])
                push!(moves, [location, [location[1] - 1, location[2] - 2]])
                push!(moves, [location, [location[1] + 2, location[2] + 1]])
                push!(moves, [location, [location[1] + 2, location[2] - 1]])
                push!(moves, [location, [location[1] - 2, location[2] + 1]])
                push!(moves, [location, [location[1] - 2, location[2] - 1]])

            elseif type == 4

                for i in 1:8
                    push!(moves, [location, [location[1] - i, location[2] - i]])
                    push!(moves, [location, [location[1] + i, location[2] + i]])
                end # for

            elseif type == 5

                # this is just all rook and bishop moves
                for i in 1:8
                    push!(moves, [location, [i, location[2]]])
                    push!(moves, [location, [location[1], i]])
                    push!(moves, [location, [location[1] - i, location[2] - i]])
                    push!(moves, [location, [location[1] + i, location[2] + i]])
                end # for

            elseif type == 6

                push!(moves, [location, [location[1] + 1, location[2]]])
                push!(moves, [location, [location[1] - 1, location[2]]])
                push!(moves, [location, [location[1] + 1, location[2] + 1]])
                push!(moves, [location, [location[1] + 1, location[2] - 1]])
                push!(moves, [location, [location[1] - 1, location[2] + 1]])
                push!(moves, [location, [location[1] - 1, location[2] - 1]])
                push!(moves, [location, [location[1], location[2] + 1]])
                push!(moves, [location, [location[1], location[2] - 1]])

            end # if

        end # for

    end # if

    valid_bool = [chIsValidPlay(game_state, move) for move in moves]
    valid = [moves[i] for i in range(1, length = length(moves)) if valid_bool[i]]
    println(valid)

    return valid

end # function

"""
    chIsValidPlay(game_state, play)

This checks a specific to see if its valid given the current game_state.
This check the following:
In bounds (1 - 8),
Not going through other pieces (except when a knight),
That the piece being landed on is not the same colour as piece it is.
"""
function chIsValidPlay(game_state::Array, play::Array{Array{Int64, 1}, 1})

    piece = [i for i in game_state if i[1] == play[1]]
    piece = piece[1]
    is_valid = true

    # check in bounds
    if play[2][1] > 8 || play[2][1] < 1 || play[2][2] > 8 || play[2][2] < 1

        is_valid = false

    elseif piece[2][1] != 3 # check not going through other pieces (if not knight)

        points = chGetPointsBetween(play)

        if length(points) == 0
            is_valid = false
        else

            for piece in game_state
                for point in points
                    if point == piece[1]

                        is_valid = false

                    end # if
                end # for
            end # for

        end # if

    end # if

    for piece in game_state
        if piece[1] == play[2] && piece[3] == 1 # check piece landing on is not on my side
            is_valid = false
        end # if
    end # for

    return is_valid

end # function

"""
    chGetPointsBetween(play::Array{Array{Int64, 1}, 1})

Gets the points between two points as per movement in chess,
i.e. along diagonals.
N/A when a knight
"""
function chGetPointsBetween(play::Array{Array{Int64, 1}, 1})

    diff_x = play[2][1] - play[1][1]
    diff_y = play[2][2] - play[1][2]

    points = []
    if diff_x != 0
        for i in 1:abs(diff_x)

            push!(points, [play[1][1] + sign(diff_x) * i, play[1][2] + sign(diff_y) * i])

        end # for
    elseif diff_y != 0
        for i in 1:abs(diff_y)

            push!(points, [play[1][1] + sign(diff_x) * i, play[1][2] + sign(diff_y) * i])

        end # for
    end # if

    return points

end # function

"""
    chShowBoard(game_state::Array)

Displays a visualisation of the board.
Doesn't discriminate between piece types but for each player.
Board is flipped vertically in display (y increases as you move down).
"""
function chShowBoard(game_state::Array)

    println("\nCurrent State: ")

    for y in 1:8
        for x in 1:8
            player = 0
            for piece in game_state
                if piece[1] == [x, y]
                    player = piece[3]
                end # if
            end # for
            if player == 1
                print("X ")
            elseif player == 2
                print("O ")
            else
                print("- ")
            end # if
        end # for
        println()
    end # for

end # function

"""
    chPlayHuman!(game_state::Array)

Takes a play from a human and parses it.
We assume the player makes legal plays (so we don't chekc it's valid).
This does not return anything, just modifies game_state
"""
function chPlayHuman!(game_state::Array)
    # Human is ALWAYS player 2

    println("Format: CurrentCoordX,CurrentCoordY,ToCoordX,ToCoordY [no spaces!]")
    print("Make your play: ")
    play = readline()
    parsed_play = [
        [parse(Int64, play[1]), parse(Int64, play[3])],
        [parse(Int64, play[5]), parse(Int64, play[7])]
    ]

    chTake!(game_state, parsed_play[2])

    for i in game_state
        if i[1] == parsed_play[1]
            i[1] = parsed_play[2]
            println("UPDATED GAME STATE: ", i)
            break
        end
    end

end # function

# Initial state in Chess!
game_state = [
    # [[locX, locY], [ID]] # PLAYER 1
    [[1, 2], [1, false], 1], # PAWNS
    [[2, 2], [1, false], 1],
    [[3, 2], [1, false], 1],
    [[4, 2], [1, false], 1],
    [[5, 2], [1, false], 1],
    [[6, 2], [1, false], 1],
    [[7, 2], [1, false], 1],
    [[8, 2], [1, false], 1],
    [[1, 1], [2], 1], # ROOKS
    [[8, 1], [2], 1],
    [[2, 1], [3], 1], # KNIGHTS
    [[7, 1], [3], 1],
    [[3, 1], [4], 1], # BISHOPS
    [[6, 1], [4], 1],
    [[4, 1], [5], 1], # QUEEN
    [[5, 1], [6], 1], # KING
    # [[locX, locY], [ID]] # PLAYER 2
    [[1, 7], [1, false], 2], # PAWNS
    [[2, 7], [1, false], 2],
    [[3, 7], [1, false], 2],
    [[4, 7], [1, false], 2],
    [[5, 7], [1, false], 2],
    [[6, 7], [1, false], 2],
    [[7, 7], [1, false], 2],
    [[8, 7], [1, false], 2],
    [[1, 8], [2], 2], # ROOKS
    [[8, 8], [2], 2],
    [[2, 8], [3], 2], # KNIGHTS
    [[7, 8], [3], 2],
    [[3, 8], [4], 2], # BISHOPS
    [[6, 8], [4], 2],
    [[4, 8], [5], 2], # QUEEN
    [[5, 8], [6], 2] # KING
]

println("BEEP BOOP")
# chShowBoard(game_state)
chMoves(game_state)
