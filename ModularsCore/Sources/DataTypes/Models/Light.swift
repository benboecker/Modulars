//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation


public struct Light: Codable, Hashable, Identifiable {
	public var id: Identifier<Self>
	public var name: String
	public var type: LightType
	public var state: State = .off
	
	public var pinID: Pin.ID?
	
	public init(name: String, type: LightType) {
		self.id = Identifier(rawValue: UUID())
		self.name = name
		self.type = type
	}
}
