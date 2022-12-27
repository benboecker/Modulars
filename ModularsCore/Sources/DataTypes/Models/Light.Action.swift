//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 12.07.22.
//

import Foundation


public extension Light {
	struct Action: Codable, Hashable {
		public let lightID: Light.ID
		public let state: Light.State
		
		public var offAction: Light.Action {
			Action(lightID: lightID, state: .off)
		}
	}
}
