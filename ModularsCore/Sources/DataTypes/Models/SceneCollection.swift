//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation


public struct SceneCollection: Codable, Hashable, Identifiable {
	public let id: Identifier<Self>
	public var name: String
	public var iconName: String? = nil
	
	public init(name: String) {
		self.id = Identifier(rawValue: UUID())
		self.name = name
	}

}
