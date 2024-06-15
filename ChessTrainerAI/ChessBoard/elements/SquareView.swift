import SwiftUI
import ChessKit

struct SquareView: View {
    let square: Square
    let piece: Piece?
    let isLegalMove: Square?

    var body: some View {
        ZStack {
            Rectangle()
                .fill(square.color == .light ? ChessConfig.lightSquareColor : ChessConfig.darkSquareColor)
                .frame(width: ChessConfig.squareSize, height: ChessConfig.squareSize)
            if let piece = piece {
                Image(piece.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ChessConfig.squareSize * 0.8, height: ChessConfig.squareSize * 0.8)
                    .opacity(piece.square == square ? 1 : 0.5)
            }
            if let isLegalMove = isLegalMove {
                Circle()
                    .frame(width: 10, height: 10)
                    .background(Color(red: 20/255, green: 20/255, blue: 20/255))
            }
        }
    }
}
