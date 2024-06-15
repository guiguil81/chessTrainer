import ChessKit
import SwiftUI

class GameModel: ObservableObject {
    @Published private(set) var game: Game
    
    private var mode: Mode
    private var boardSide: Piece.Color
    
    /// Initialise un nouvel échiquier avec la position de départ standard.
    init(mode: Mode, boardSide: Piece.Color) {
        self.game = Game(startingWith: .standard)
        self.mode = mode
        self.boardSide = boardSide
    }
    
    /// get the pgn position for game
    func getPgn() -> String {
        return game.pgn
    }
    
    /// get boardSide
    func getBoardSide() -> Piece.Color {
        return boardSide
    }
    
    /// get boardSide
    func getMode() -> Mode {
        return mode
    }
}
