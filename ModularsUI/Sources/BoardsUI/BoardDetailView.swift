//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import SwiftUI
import DataTypes
import SharedUI
import Repositories


struct BoardDetailView: View {
	
	@Binding var board: Board
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var boardsRepository: BoardsRepository
	
    var body: some View {
//		NavigationView {
			Form {
				Section("Infos") {
					TextField("Name", text: $board.name)
					TextField("IP-Adresse", text: $board.address)
						.font(.system(.body, design: .monospaced))
				}
				Section("Pins") {
					ForEach(board.pins, id: \.self) { pin in
						PinCell(pin: pin)
							.contextMenu {
								Button {
									set(pin, to: .off)
								} label: {
									Label("Aus", systemImage: "light.min")
								}
								Button {
									set(pin, to: .on)
								} label: {
									Label("An", systemImage: "light.max")
								}
							}
					}
				}
			}
			.navigationTitle("Board bearbeiten")
//			.toolbar {
//				ToolbarItem(placement: .navigationBarLeading) {
//					Button {
//						presentationMode.wrappedValue.dismiss()
//					} label: {
//						Image(systemName: "multiply.circle.fill")
//							.font(.title2.bold())
//							.symbolRenderingMode(.hierarchical)
//							.foregroundColor(.gray)
//
//					}
//				}
//			}
//		}
    }
	
	func set(_ pin: Pin, to state: Pin.State) {
		Task {
			switch state {
			case .on: try await boardsRepository.send(.pinOn(pinID: pin.id))
			case .off: try await boardsRepository.send(.pinOff(pinID: pin.id))
			}
		}
	}
}


struct BoardDetailView_Previews: PreviewProvider {
    static var previews: some View {
		BoardDetailView(board: .constant(Board(address: "127.0.0.1", name: "Board 1")))
			.previewDevice("iPhone 13 mini")
    }
}
