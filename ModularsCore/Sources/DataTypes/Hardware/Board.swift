//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation


public struct Board: Codable, Identifiable, Hashable {
	public var id: Identifier<Self>
	
	public var address: String
	public var name: String
	public var pins: [Pin]
	public var state: State
	
	
	public init(address: String, name: String, state: State = .unknown) {
		self.id = Identifier(rawValue: UUID())
		self.address = address
		self.name = name
		self.pins = Pin.allPins
		self.state = state
	}
}
