//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import SwiftUI
import Repositories
import Constants
import DataTypes


public struct BoardsView: View {
	
	@EnvironmentObject var boardsRepository: BoardsRepository
	
	public init() { }
	
	private let columns: [GridItem] = [
		GridItem(.flexible(minimum: 100, maximum: 200), spacing: 24),
		GridItem(.flexible(minimum: 100, maximum: 200), spacing: 24),
	]
	
	@State private var isShowingDeleteAlert = false
	@State private var boardIDToDelete: Board.ID?

	public var body: some View {
		NavigationView {
			ScrollView {
				LazyVGrid(columns: columns, spacing: 24) {
					ForEach($boardsRepository.data) { board in
						NavigationLink {
							BoardDetailView(board: board)
						} label: {
							BoardCell(board: board.wrappedValue)
						}
						.contextMenu {
							Button(role: .destructive) {
								isShowingDeleteAlert = true
								boardIDToDelete = board.id
							} label: {
								Label("Löschen", systemImage: "trash")
							}
						}
					}
				}
				.padding()
				.alert("Board löschen?", isPresented: $isShowingDeleteAlert) {
					Button("Abbrechen", role: .cancel) {
						isShowingDeleteAlert = false
					}
					Button("Löschen", role: .destructive) {
						isShowingDeleteAlert = false
						guard let boardIDToDelete else { return }
						boardsRepository.deleteBoard(with: boardIDToDelete)
						self.boardIDToDelete = nil
					}
				}
			}
			.background(Color.primaryBackground)
			.navigationTitle("Boards")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						boardsRepository.createNewBoard()
					} label: {
						Image(systemName: "plus.circle.fill")
							.font(.title2.bold())
							.symbolRenderingMode(.hierarchical)
					}
				}
			}
		}
		.task {
			do {
				try await boardsRepository.updateBoardsStates()
			} catch {
				fatalError("\(error)")
			}
		}
		.tabItem {
			Label("Boards", systemImage: "cpu")
		}
	}
}

struct BoardsView_Previews: PreviewProvider {
    static var previews: some View {
		BoardsView()
			.environmentObject(BoardsRepository())
		BoardsView()
			.environmentObject(BoardsRepository())
			.preferredColorScheme(.dark)
    }
}
