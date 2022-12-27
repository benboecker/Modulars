//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation


public protocol Repository: SingleFileStorage {
	var data: [T] { get set }
	func save() async throws
}


public extension Repository {
	func save() async throws {
		try await saveData(data)
	}	
}

