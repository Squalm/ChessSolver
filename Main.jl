### Main bits of a game

# Game state structure
# game_state = [
#   [Location, [PieceID, (Already moved, if pawn)]]
# ]

function chSearch(game_state)

end # function

# Get moves for any piece
function chValidMoves(game_state, piece_location)

    # Different numbers in the piece type indicate pieces
    # 1 -> Pawn - Extra info: Already moved [bool]
    # 2 -> Rook
    # 3 -> Knight
    # 4 -> Bishop
    # 5 -> Queen
    # 6 -> King

end # function

function chIsValidPlay(game_state, piece_to)

    return true

end # function

# Read in a player's input into the code
function chPlayHuman(game_state)

    println("Format: CurrentCoordX,CurrentCoordY,ToCoordX,ToCoordY [no spaces!]")
    print("Make your play: ")
    play = readline()
    parsed_play = [
        [parse(Int64, play[1]), parse(Int64, play[3])],
        [parse(Int64, play[5]), parse(Int64, play[7])]
    ]

    if chIsValidPlay(game_state, [parsed_play[2]])
        for i in game_state
            if i[1] == parsed_play[1]
                i[1] = parsed_play[2]
                println("UPDATED GAME STATE: ", i)
                break
            end
        end
    else
        println("\nINVALID PLAY")
        chPlayHuman(game_state)
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
    [[5, 1], [6], 1] # KING
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
