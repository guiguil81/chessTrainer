import ChessKit
import SwiftUI

class BoardModel: ObservableObject {
    @Published private(set) var board: Board

    /// Initialise un nouvel échiquier avec la position de départ standard.
    init() {
        self.board = Board(position: .standard)
    }

    /// Effectue un mouvement d'une case à une autre.
    func makeMove(from: Square, to: Square) -> Bool {
        if board.move(pieceAt: from, to: to) != nil {
            return true
        }
        return false
    }
    
    /// Permet de savoir si le mouvement est autorisé
    func canMakeMove(from: Square, to: Square) -> Bool {
        return board.canMove(pieceAt: from, to: to)
    }
    
    /// Permet de completer la promotion du pawn
    func promotePawn(move: Move, to: Piece.Kind) -> Bool {
        board.completePromotion(of: move, to: to)
        return true
    }
    
    /// Permet d'obtenir toutes les Square possible d'une pièce
    func legalsMoves(at: Square) -> [Square: Square] {
        var piecesDictionary: [Square: Square] = [:]
        for square in board.legalMoves(forPieceAt: at) {
            piecesDictionary[square] = square
        }

        return piecesDictionary
    }
    
    /// Obtient la pièce à une case spécifique.
    func piece(at square: Square) -> Piece? {
        return board.position.piece(at: square)
    }

    /// Obtient toutes les pièces avec leurs positions actuelles.
    func allPieces() -> [Square: Piece] {
        var piecesDictionary: [Square: Piece] = [:]
        for piece in board.position.pieces {
            piecesDictionary[piece.square] = piece
        }

        return piecesDictionary
    }
    
    /// Obtient la couleur du prochain coup que peux jouer le joueur
    func sideToMove() -> Piece.Color {
        return board.position.sideToMove
    }
    
    /// Permet d'avoir la le fen de la position
    func fenBoard(at: Square) -> String {
        return board.position.fen
    }
    
    /// Réinitialise l'échiquier à la position de départ standard.
    func resetBoard() {
        self.board = Board(position: .standard)
    }
}
