//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation


public extension Light {
	enum State: Hashable, Codable {
		case on, off
		case rgb(red: Float, green: Float, blue: Float)
		case dimmed(Float)
	}
}
