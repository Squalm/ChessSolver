### Main bits of a game

# Game state structure
# game_state = [
#   [Location, [PieceID, (Already moved, if pawn)]]
# ]

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

        location = piece[1]
        type = piece[2][1]

        if type == 1

            already_moved = piece[2][2]

            moves[end + 1] = [location, [location[1], location[2] + 1]]
            if !already_moved
                moves[end + 1] = [location, [location[1], location[2] + 2]]
            end # if

        elseif type == 2

            for i in 1:9
                moves[end + 1] = [location, [i, location[2]]]
                moves[end + 1] = [location, [location[1], i]]
            end # for

        elseif type == 3

            moves[end + 1] = [location, [location[1] + 1, location[2] + 2]]
            moves[end + 1] = [location, [location[1] - 1, location[2] + 2]]
            moves[end + 1] = [location, [location[1] + 1, location[2] - 2]]
            moves[end + 1] = [location, [location[1] - 1, location[2] - 2]]
            moves[end + 1] = [location, [location[1] + 2, location[2] + 1]]
            moves[end + 1] = [location, [location[1] + 2, location[2] - 1]]
            moves[end + 1] = [location, [location[1] - 2, location[2] + 1]]
            moves[end + 1] = [location, [location[1] - 2, location[2] - 1]]

        elseif type == 4

            for i in 1:9
                moves[end + 1] = [location, [location[1] - i, location[2] - i]]
                moves[end + 1] = [location, [location[1] + i, location[2] + i]]
            end # for

        elseif type == 5

            # this is just all rook and bishop moves
            for i in 1:9
                moves[end + 1] = [location, [i, location[2]]]
                moves[end + 1] = [location, [location[1], i]]
                moves[end + 1] = [location, [location[1] - i, location[2] - i]]
                moves[end + 1] = [location, [location[1] + i, location[2] + i]]
            end # for

        elseif type == 6

            moves[end + 1] = [location, [location[1] + 1, location[2]]]
            moves[end + 1] = [location, [location[1] - 1, location[2]]]
            moves[end + 1] = [location, [location[1] + 1, location[2] + 1]]
            moves[end + 1] = [location, [location[1] + 1, location[2] - 1]]
            moves[end + 1] = [location, [location[1] - 1, location[2] + 1]]
            moves[end + 1] = [location, [location[1] - 1, location[2] - 1]]
            moves[end + 1] = [location, [location[1], location[2] + 1]]
            moves[end + 1] = [location, [location[1], location[2] - 1]]

        end # if

    end # for


    return valid

end # function

function chIsValidPlay(game_state, play)

    piece = [i for i in game_state if i[1] == play[1]]
    is_valid = true

    # check in bounds
    # check not going through other pieces (if not knight)

    return is_valid

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

chPlayHuman(game_state)
