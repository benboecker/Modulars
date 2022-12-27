//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation
import PHNetworking
import DataTypes




public struct BoardConnection {
	
	public init() { }
}


public extension BoardConnection {
	func getState(of board: Board) async -> Board.State {
		guard URL(string: board.address) != nil else { return .unknown }
		do {
			try await getData(.status(for: board.address))
			return .online
		} catch {
			return .offline
		}
	}
	
	func getState(of pin: Pin, on board: Board) async throws -> Pin.State {
		try await getData(
			.status(for: board.address, pin: pin.internalNumber)
		)
	}
	
	@discardableResult func setPinOff(_ pin: Pin, on board: Board) async throws -> Pin.State {
		try await getData(
			.pinOff(for: board.address, pin: pin.internalNumber)
		)
	}
	
	@discardableResult func setPinOn(_ pin: Pin, on board: Board) async throws -> Pin.State {
		try await getData(
			.pinOn(for: board.address, pin: pin.internalNumber)
		)
	}
}

private extension BoardConnection {
	
	func getData<T: Decodable>(_ endpoint: BoardEndpoint) async throws -> T {
		try await URLSession.shared.downloadData(from: endpoint)
	}
	
	func getData(_ endpoint: BoardEndpoint) async throws {
		let _ = try await URLSession.shared.downloadData(from: endpoint)
	}
}
