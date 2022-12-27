//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation


public protocol Identifiable: Swift.Identifiable {
	associatedtype RawIdentifier: Codable & Hashable = UUID
	var id: Identifier<Self> { get }
}


public struct Identifier<Value: Identifiable>: Hashable {
	public let rawValue: Value.RawIdentifier
	
	public init(rawValue: Value.RawIdentifier) {
		self.rawValue = rawValue
	}
}


extension Identifier: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		rawValue = try container.decode(Value.RawIdentifier.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}
