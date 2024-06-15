// PieceExtension.swift
import ChessKit

extension Piece {
    var imageName: String {
        let colorPrefix = color == .white ? "white" : "black"
        switch kind {
        case .pawn:   return "\(colorPrefix)_pawn"
        case .bishop: return "\(colorPrefix)_bishop"
        case .knight: return "\(colorPrefix)_knight"
        case .rook:   return "\(colorPrefix)_rook"
        case .queen:  return "\(colorPrefix)_queen"
        case .king:   return "\(colorPrefix)_king"
        }
    }
}
