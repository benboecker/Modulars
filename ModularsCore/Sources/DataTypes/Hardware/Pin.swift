//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation



public struct Pin: Codable, Identifiable, Hashable {
	public let id: Identifier<Self>
	public let internalNumber: Int
	public let title: String
	public let gpio: String
	public var state: State = .off
	
	init(internalNumber: Int, title: String, gpio: String) {
		self.id = Identifier(rawValue: UUID())
		self.internalNumber = internalNumber
		self.title = title
		self.gpio = gpio
	}
}



public extension Pin {
	static var allPins: [Pin] { [
		Pin(internalNumber: 0, title: "D0", gpio: "GPIO 16"),
		Pin(internalNumber: 1, title: "D1", gpio: "GPIO 5"),
		Pin(internalNumber: 2, title: "D2", gpio: "GPIO 4"),
		Pin(internalNumber: 3, title: "D3", gpio: "GPIO 0"),
		Pin(internalNumber: 4, title: "D4", gpio: "GPIO 2"),
		Pin(internalNumber: 5, title: "D5", gpio: "GPIO 14"),
		Pin(internalNumber: 6, title: "D6", gpio: "GPIO 12"),
		Pin(internalNumber: 7, title: "D7", gpio: "GPIO 13"),
		Pin(internalNumber: 8, title: "D8", gpio: "GPIO 15"),
		Pin(internalNumber: 9, title: "RX", gpio: "GPIO 3"),
		Pin(internalNumber: 10, title: "TX", gpio: "GPIO 1"),
		Pin(internalNumber: 11, title: "SD2", gpio: "GPIO 9"),
		Pin(internalNumber: 12, title: "SD3", gpio: "GPIO 10"),
	] }
}



public extension Pin {
	enum State: String, Codable {
		case on, off
		
//		public init(from decoder: Decoder) throws {
//			let container = try decoder.container(keyedBy: CodingKeys.self)
//			
//			let status = try container.decode(String.self, forKey: .status)
//			
//			switch status {
//			case "on": self = .on
//			default: self = .off
//			}
//		}
//		
//		public func encode(to encoder: Encoder) throws {
//			var container = encoder.container(keyedBy: CodingKeys.self)
//			
//			try container.encode(self == .on ? "on" : "off", forKey: .status)
//		}
//		
//		enum CodingKeys: String, CodingKey {
//			case status
//		}
	}
}
