//
//  Storage.swift
//  Tracks
//
//  Created by Benjamin Böcker on 05.05.22.
//

import Foundation


/// Stores `Codable` data asynchronously in a file in the documents directory.
public protocol Storage {
	associatedtype T: Codable
	
	func loadData(from filename: String) async throws -> [T]
	func saveData(_ data: [T], to filename: String) async throws
}


public extension Storage {
	func loadData(from filename: String) async throws -> [T] {
		try await withCheckedThrowingContinuation { continuation in
			loadData(from: filename) { result in
				switch result {
				case .success(let decodedData):
					continuation.resume(returning: decodedData)
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func saveData(_ data: [T], to filename: String) async throws {
		try await withCheckedThrowingContinuation { (continuation: (CheckedContinuation<Void, Error>)) in
			saveData(data: data, to: filename) { result in
				switch result {
				case .success:
					continuation.resume()
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}

private extension Storage {
	var storageDirectory: URL {
		FileManager.default
			.urls(for: .documentDirectory, in: .userDomainMask)[0]
	}
	
	func loadData(from filename: String, completion: @escaping (Result<[T], Error>) -> Void) {
		DispatchQueue.global(qos: .background).async {
			do {
				let url = storageDirectory.appendingPathComponent("\(filename).json")
				guard let file = try? FileHandle(forReadingFrom: url) else {
					DispatchQueue.main.async {
						completion(.success([]))
					}
					return
				}

				let decodedData = try JSONDecoder().decode([T].self, from: file.availableData)
				DispatchQueue.main.async {
					completion(.success(decodedData))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
	}

	func saveData(data: [T], to filename: String, completion: @escaping (Result<Void, Error>) -> Void) {
		DispatchQueue.global(qos: .background).async {
			do {
				let data = try JSONEncoder().encode(data)
				let url = storageDirectory.appendingPathComponent("\(filename).json")

				try data.write(to: url)
				DispatchQueue.main.async {
					completion(.success(()))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
	}
}
