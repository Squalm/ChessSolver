### Main bits of a game

# Game state structure
# game_state = [
#   [Location, [PieceID, (Already moved, if pawn)]]
# ]

# REMAIN VIGILANTLY AWARE OF ARGUMENT PASSING BEHAVIOR
function chSearch(game_state)

end # function

# Computer make play
# This will also resolve the game_state when called finally
function chMakePlay(game_state, play)

end # function

# Run one turn for computer
function chResolve(game_state)

end # function

# RUN THE ENTIRE GAME
# Note how this takes game_state allowing for other starting conditions
function chRunGame(game_state)

end # function

# Get all POSSIBLE VALID moves the computer can make
# Computer always assumes it is on bottom
function chMoves(game_state)

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

function chShowBoard(game_state)

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

# Read in a player's input into the code
function chPlayHuman(game_state)
    # Human is ALWAYS player 2

    println("Format: CurrentCoordX,CurrentCoordY,ToCoordX,ToCoordY [no spaces!]")
    print("Make your play: ")
    play = readline()
    parsed_play = [
        [parse(Int64, play[1]), parse(Int64, play[3])],
        [parse(Int64, play[5]), parse(Int64, play[7])]
    ]

    for i in game_state
        if i[1] == parsed_play[1]
            i[1] = parsed_play[2]
            println("UPDATED GAME STATE: ", i)
            break
        end
    end

    return game_state

end # function

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
