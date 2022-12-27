//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation
import DataTypes
import BoardConnection



public class SceneRepository: ObservableObject, Repository {
	public typealias T = Scene
	public let filename = "scenes"
	public var lightRepository: LightsRepository!
	
	@Published public var data: [Scene] = []
		
	public init() { }
}


public extension SceneRepository {
	subscript(_ id: Scene.ID) -> Scene {
		data.first { $0.id == id }!
	}
	
	@discardableResult func createNewScene(in collectionID: SceneCollection.ID) -> Scene {
		let newScene = Scene(title: "Szene \(data.count + 1)", collectionID: collectionID)
		data.append(newScene)
		return newScene
	}
	
	func deleteScene(with id: Scene.ID) {
		data.removeAll { scene in
			scene.id == id
		}
	}
	
	func deleteScenes(in sceneCollectionID: SceneCollection.ID) {
		data.removeAll { scene in
			scene.collectionID == sceneCollectionID
		}
	}
	
	@MainActor
	func toggleScene(with id: Scene.ID) async throws {
		guard let sceneIndex = data.firstIndex(where: { $0.id == id}) else {
			return
		}
		
		data[sceneIndex].isOn.toggle()
		
		let actions = data[sceneIndex].actions
		
		if data[sceneIndex].isOn {
			try await lightRepository.performActions(actions)
		} else {
			try await lightRepository.performActions(actions.map(\.offAction))
		}
	}
}

