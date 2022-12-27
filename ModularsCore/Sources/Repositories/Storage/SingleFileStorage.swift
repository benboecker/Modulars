//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 15.05.22.
//

import Foundation


public protocol SingleFileStorage: Storage {
	var filename: String { get }
	
	func loadData() async throws -> [T]
	func saveData(_ data: [T]) async throws
}


extension SingleFileStorage {
	public func loadData() async throws -> [T] {
		try await loadData(from: filename)
	}
	
	public func saveData(_ data: [T]) async throws {
		try await saveData(data, to: filename)
	}

}
