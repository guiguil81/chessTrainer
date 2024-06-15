import SwiftUI
import ChessKit

class BoardModelView: ObservableObject {
    @Published var gameModel: GameModel

    @Published var boardPieces: [Square: Piece] = [:]
    @Published var legalsMoves: [Square: Square] = [:]
    @Published var selectedPiece: Piece? = nil
    @Published var targetSquare: Square? = nil
    @Published var isAnimating: Bool = false
    @Published var draggedPiece: Piece? = nil
    @Published var draggedPieceStartSquare: Square? = nil
    @Published var draggedPiecePosition: CGPoint = .zero
    @Published var initDraggedPosition: CGPoint = .zero
    
    private var boardModel = BoardModel()

    init(gameModel: GameModel) {
        self.gameModel = gameModel
        self.boardPieces = boardModel.allPieces()
    }

    // Méthode pour effectuer un mouvement
    func movePiece(from start: Square, to end: Square) {
        let move = boardModel.makeMove(from: start, to: end)
        
        if move {
            self.boardPieces = boardModel.allPieces()
        }
    }
    
    // Méthode pour vérifier si un mouvement est valide
    func canMovePiece(from start: Square, to end: Square) -> Bool {
        return boardModel.canMakeMove(from: start, to: end)
    }
    
    // Méthode pour obtenir les mouvements possible
    func getLegalsMoves(at: Square) {
        self.legalsMoves = boardModel.legalsMoves(at: at)
    }
    
    // Méthode pour reset les mouvements possible
    func resetLegalsMoves() {
        self.legalsMoves = [:]
    }
}
