//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import DataTypes


public class SceneCollectionRepository: ObservableObject, Repository {
	public typealias T = SceneCollection
	public let filename = "scene_collections"
	
	@Published public var data: [SceneCollection] = []
	
	public init() {
		#if DEBUG
		
		#endif
	}
}


public extension SceneCollectionRepository {
	subscript(_ id: SceneCollection.ID) -> SceneCollection {
		data.first { $0.id == id }!
	}
	
	@discardableResult func createSceneCollection() -> SceneCollection {
		let newSceneCollection = SceneCollection(name: "Collection \(data.count + 1)")
		data.append(newSceneCollection)
		return newSceneCollection
	}
	
	func deleteSceneCollection(with id: SceneCollection.ID) {
		data.removeAll { sc in
			sc.id == id
		}
	}

}
