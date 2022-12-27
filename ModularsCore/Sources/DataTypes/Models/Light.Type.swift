//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation


public extension Light {
	enum LightType: Codable, Hashable, CaseIterable {
		case onOff, rgb, dimmed
		
		public var title: String {
			switch self {
			case .onOff: return "An / Aus"
			case .rgb: return "RGB"
			case .dimmed: return "Dimmer"
			}
		}
	}
}
