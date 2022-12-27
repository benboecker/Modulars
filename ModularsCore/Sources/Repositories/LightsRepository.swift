//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import DataTypes



public class LightsRepository: ObservableObject, Repository {
	public typealias T = Light
	public let filename = "lights"
	public var boardsRepository: BoardsRepository!

	@Published public var data: [Light] = []
	
	public init() {
		data = [
			Light(name: "Light 1", type: .onOff),
			Light(name: "Light 2", type: .onOff),
			Light(name: "Light 3", type: .rgb),
			Light(name: "Light 4", type: .dimmed),
			Light(name: "Light 5", type: .dimmed),
		]
	}
}


public extension LightsRepository {
	subscript(_ id: Light.ID) -> Light {
		data.first { $0.id == id }!
	}
	
	subscript(_ id: Pin.ID) -> Light? {
		data.first { $0.pinID == id }
	}
	
	@discardableResult func createNewLight() -> Light {
		let newLight = Light(name: "Light \(data.count + 1)", type: .onOff)
		data.append(newLight)
		return newLight
	}
	
	func deleteLight(with id: Light.ID) {
		data.removeAll { light in
			light.id == id
		}
	}
	
	func performActions(_ actions: [Light.Action]) async throws {
		var boardCommands: [Board.Command] = []
		
		for action in actions {
			let light = self[action.lightID]
			
			guard
				let lightIndex = data.firstIndex(where: { $0.id == action.lightID} ),
				let pinID = light.pinID
			else { return }
			
			data[lightIndex].state = action.state
			
			switch action.state {
			case .on: boardCommands.append(.pinOn(pinID: pinID))
			case .off: boardCommands.append(.pinOff(pinID: pinID))
			default: fatalError()
			}
		}
		
		try await boardsRepository.send(boardCommands)
	}
}
