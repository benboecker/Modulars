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
import SharedUI



struct LightRow: View {
	
	let light: Light
	@EnvironmentObject private var boardsRepository: BoardsRepository

	
	var body: some View {
		
		HStack {
			TypeImage
			Text(light.name)
			Spacer()
			
			if let board = board, let pin = pin {
				VStack(alignment: .leading) {
					Label(board.name, systemImage: "cpu")
						.font(.callout)
						.foregroundColor(.secondary)
						.labelStyle(FixedWidthLabelStyle())
					Label(pin.title, systemImage: "cable.connector.horizontal")
						.font(.callout)
						.foregroundColor(.secondary)
						.labelStyle(FixedWidthLabelStyle())
				}
			}
		}
		.padding(.vertical, 6)
		.padding(.trailing, 12)

	}
	
	var TypeImage: Image {
		let imageName: String
		switch light.type {
		case .onOff: imageName = "light.max"
		case .rgb: imageName = "light.max"
		case .dimmed: imageName = "light.max"
		}
		
		return Image(systemName: imageName)
	}
	
	var board: Board? {
		guard let id = light.pinID else { return nil }
		return boardsRepository[id]
	}
	
	var pin: Pin? {
		guard let id = light.pinID else { return nil }
		return boardsRepository[id]
	}
}





struct LightRow_Previews: PreviewProvider {
	static var previewData: [Light] {
		var light1 = Light(name: "Licht 1", type: .onOff)
		var light2 = Light(name: "Licht 2", type: .rgb)
		let light3 = Light(name: "Licht 3", type: .onOff)
		let repo = BoardsRepository()
		light1.pinID = repo.data.first!.pins.first!.id
		light2.pinID = repo.data.last!.pins.last!.id
		
		return [light1, light2, light3]
	}
	
	static var previews: some View {
		Group {
			LightRow(light: previewData[0])
			LightRow(light: previewData[1])
			LightRow(light: previewData[2])
		}
		.environmentObject(BoardsRepository())
		.padding()
		.previewLayout(.fixed(width: 400, height: 100))
	}
}
