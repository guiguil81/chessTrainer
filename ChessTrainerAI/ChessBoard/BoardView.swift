import SwiftUI
import ChessKit

struct BoardView: View {
    @ObservedObject var viewModel: BoardModelView

    let squareSize = ChessConfig.squareSize
    let boardSize = ChessConfig.squareSize * 8
        
    var body: some View {
        let sideBoard: Piece.Color = viewModel.gameModel.getBoardSide()
            
        ZStack {
            VStack(spacing: 0) {
                let row: [Int] = sideBoard == .black ? Array(1...8) : Array((1...8).reversed())
                ForEach(row, id: \.self) { rank in
                    HStack(spacing: 0) {
                        let allCases: [Square.File] = sideBoard == .black ? Square.File.allCases : Square.File.allCases.reversed()
                        ForEach(allCases, id: \.self) { file in
                            let notation = "\(file.rawValue)\(rank)"
                            let square = Square(notation)

                            SquareView(square: square, piece: viewModel.boardPieces[square], isLegalMove: viewModel.legalsMoves[square])
                                .onTapGesture {
                                    handleTap(on: square)
                                }
                                .overlay(
                                    viewModel.draggedPiece != nil && viewModel.draggedPiece?.square == square ? Color.black.opacity(0.5) : Color.clear
                                )
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if viewModel.draggedPiece == nil, let piece = viewModel.boardPieces[square] {
                                                viewModel.draggedPiece = piece
                                                viewModel.draggedPieceStartSquare = square
                                            }
                                            if viewModel.initDraggedPosition == .zero {
                                                viewModel.initDraggedPosition = CGPoint(x: value.startLocation.x, y: value.startLocation.y)
                                            }
                                            
                                            if let draggedPiece = viewModel.draggedPiece, viewModel.initDraggedPosition != .zero {
                                                var startRow: Int
                                                var startColumn: Int
                                                
                                                if (sideBoard == .black) {
                                                    startRow = draggedPiece.square.rank.value - 1
                                                    startColumn = draggedPiece.square.file.number - 1
                                                } else {
                                                    startRow = 8 - draggedPiece.square.rank.value
                                                    startColumn = 8 - draggedPiece.square.file.number
                                                }

                                                viewModel.draggedPiecePosition = CGPoint(
                                                    x: CGFloat(startColumn) * squareSize + value.translation.width + viewModel.initDraggedPosition.x,
                                                    y: CGFloat(startRow) * squareSize + value.translation.height + viewModel.initDraggedPosition.y
                                                )
                                            }
                                        }
                                        .onEnded { value in
                                            if let draggedPieceStartSquare = viewModel.draggedPieceStartSquare {
                                                let endRow = Int(viewModel.draggedPiecePosition.x / squareSize)
                                                let endColumn = Int(viewModel.draggedPiecePosition.y / squareSize)

                                                if (endColumn >= 0 && endColumn < 8 && endRow >= 0 && endRow < 8) {
                                                    var file: Square.File
                                                    var rank: Int
                                                    
                                                    if (sideBoard == .black) {
                                                        file = Square.File.init(endRow + 1)
                                                        rank = Square.Rank.init(endColumn + 1).value
                                                    } else {
                                                        file = Square.File.init(8 - endRow)
                                                        rank = Square.Rank.init(8 - endColumn).value
                                                    }
                                                    
                                                    let targetSquare = Square("\(file)\(rank)")
                                                    
                                                    if viewModel.canMovePiece(from: draggedPieceStartSquare, to: targetSquare) {
                                                        viewModel.movePiece(from: draggedPieceStartSquare, to: targetSquare)
                                                    }
                                                }

                                                viewModel.draggedPiece = nil
                                                viewModel.draggedPieceStartSquare = nil
                                                viewModel.draggedPiecePosition = .zero
                                                viewModel.initDraggedPosition = .zero
                                            }
                                        }
                                )
                        }
                    }
                }
            }

            // Pièce en cours de drag and drop
            if let draggedPiece = viewModel.draggedPiece {
                Image(draggedPiece.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: squareSize * 0.8, height: squareSize * 0.8)
                    .position(viewModel.draggedPiecePosition)
                    .opacity(0.75)
            }
        }
        .frame(width: boardSize, height: boardSize)
    }

    func handleTap(on square: Square) {
        let piece = viewModel.boardPieces[square]
        
        if let selectedPiece = viewModel.selectedPiece {
            // Déplacement de la pièce si une pièce est déjà sélectionnée
            if viewModel.canMovePiece(from: selectedPiece.square, to: square) {
                withAnimation {
                    viewModel.movePiece(from: selectedPiece.square, to: square)
                }
                viewModel.selectedPiece = nil
            } else {
                // Annuler la sélection si la case cible n'est pas valide
                viewModel.selectedPiece = nil
            }
        } else if let piece = viewModel.boardPieces[square] {
            // Sélectionner la pièce si aucune pièce n'est sélectionnée
            viewModel.selectedPiece = piece
            viewModel.getLegalsMoves(at: square)
        }
    }
}

