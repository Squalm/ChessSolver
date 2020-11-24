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

    if chIsValidPlay(game_state, [parsed_play[2][1], parsed_play[2][2]])
        for i in game_state
            if i[1] == parsed_play[1]
                i[1] = parsed_play[1]
                break
            end
        end
    else
        println("\nINVALID PLAY")
        chPlayHuman(game_state)
    end

end # function

game_state = [[[1, 3], [1, true]]]
chPlayHuman(game_state)
