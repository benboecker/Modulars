//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation


public extension Board {
	enum Command: Hashable, Codable {
		case pinOn(pinID: Pin.ID)
		case pinOff(pinID: Pin.ID)
		
		case pinState(pinID: Pin.ID)
		case boardState(boardID: Board.ID)
	}
}
