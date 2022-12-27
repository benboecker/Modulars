//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation


public struct Scene: Hashable, Identifiable, Codable {	
	public let id: Identifier<Self>
	public var title: String
	public var iconName: String?
	public var actions: [Light.Action] = []
	public var collectionID: SceneCollection.ID
	public var isOn = false
	
	public init(title: String, collectionID: SceneCollection.ID) {
		self.id = Identifier(rawValue: UUID())
		self.title = title
		self.collectionID = collectionID
	}
}


