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
import BoardsUI


struct LightDetailView: View {

	@Binding var light: Light

	@State private var selectedPin: Pin?
	@State private var isSelectingPin = false
	@EnvironmentObject private var boardsRepository: BoardsRepository

    var body: some View {
		Form {
			Section("Name") {
				TextField("Name", text: $light.name)
			}
			Section("Typ") {
				Picker("Lichttyp auswählen", selection: $light.type) {
					ForEach(Light.LightType.allCases, id: \.self) { type in
						Text(type.title)
							.tag(type)
					}
				}
				.pickerStyle(.segmented)
			}
			Section("Pin") {
				Button {
					isSelectingPin = true
				} label: {
					if let pin = selectedPin {
						PinCell(pin: pin)
							.listRowBackground(Color.secondaryBackground)
					} else {
						Text("Auswahl")
							.listRowBackground(Color.secondaryBackground)
					}
				}
			}
		}
		.navigationTitle("Licht bearbeiten")
		.navigationBarTitleDisplayMode(.inline)
		.onAppear {
			guard let id = self.light.pinID else { return }
			selectedPin = boardsRepository[id]
		}
		.sheet(isPresented: $isSelectingPin) {
			light.pinID = selectedPin?.id
		} content: {
			PinSelectionView(selectedPin: $selectedPin)
		}

    }
}



struct LightDetailView_Previews: PreviewProvider {
    static var previews: some View {
		LightDetailView(light: .constant(Light(name: "Light 1", type: .onOff)))
			.environmentObject(BoardsRepository())
    }
}
