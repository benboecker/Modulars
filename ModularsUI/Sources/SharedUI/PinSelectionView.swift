//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import SwiftUI
import DataTypes
import Repositories
import Constants



public struct PinSelectionView: View {
	
	@EnvironmentObject var boardsRepository: BoardsRepository
	@Binding var selectedPin: Pin?
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var lightsRepository: LightsRepository

	
	public init(selectedPin: Binding<Pin?>) {
		self._selectedPin = selectedPin
	}
	
	public var body: some View {
		NavigationView {
			List {
				Button {
					selectedPin = nil
					presentationMode.wrappedValue.dismiss()
				} label: {
					Label("Pin entfernen", systemImage: "trash")
						.tint(.red)
						.foregroundColor(.red)
				}

				ForEach(boardsRepository.data) { board in
					Section(board.name) {
						ForEach(board.pins) { pin in
							PinCell(pin: pin, light: lightsRepository[pin.id])
//								.background(Color.clear)
								.onTapGesture {
									selectedPin = pin
									presentationMode.wrappedValue.dismiss()
								}
						}
					}
				}
			}
			.navigationTitle("Pin auswählen")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						Image(systemName: "multiply.circle.fill")
							.font(.title2.bold())
							.symbolRenderingMode(.hierarchical)
					}
				}
			}
		}
	}
}


struct PinSelectionView_Previews: PreviewProvider {
	static var previews: some View {
		PinSelectionView(selectedPin: .constant(nil))
			.environmentObject(BoardsRepository())
	}
}
