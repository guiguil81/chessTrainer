import ChessKit

enum GameState {
    case ongoing
    case check
    case checkmate(winner: Piece.Color)
    case draw(reason: DrawReason)
    
    enum DrawReason {
        case stalemate
        case insufficientMaterial
        case fiftyMoveRule
    }
}
