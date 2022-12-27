//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import SwiftUI

public extension Board {
	enum State: Codable, Hashable {
		case online
		case offline
		case unknown
	}
}
