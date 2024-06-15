import SwiftUI

struct TrainingView: View {
    @StateObject private var gameModel = GameModel(mode: .creative, boardSide: .white)

    var body: some View {
        let boardViewModel = BoardModelView(gameModel: gameModel)
        BoardView(viewModel: boardViewModel)
    }
}
