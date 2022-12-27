//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import Foundation
import DataTypes
import BoardConnection


public class BoardsRepository: ObservableObject, Repository {
	public typealias T = Board
	public let filename = "boards"
	
	@Published public var data: [Board] = []
	
	private let boardConnection = BoardConnection()
	
	public init() {
		data = [
			Board(address: "127.0.0.1", name: "Board 1", state: .online),
			Board(address: "127.0.0.1", name: "Board 1", state: .offline),
			Board(address: "127.0.0.1", name: "Board 1", state: .unknown),
		]
	}
}


public extension BoardsRepository {	
	subscript(_ id: Board.ID) -> Board {
		data.first { $0.id == id }!
	}
	
	subscript(_ id: Pin.ID) -> Board {
		data.first { $0.pins.map(\.id).contains(id) }!
	}
	
	subscript(_ id: Pin.ID) -> Pin {
		for board in data {
			for pin in board.pins where pin.id == id {
				return pin
			}
		}
		
		fatalError()
	}
	
	@discardableResult func createNewBoard() -> Board {
		let newBoard = Board(address: "", name: "Board \(data.count + 1)")
		data.append(newBoard)
		return newBoard
	}
	
	func deleteBoard(with id: Board.ID) {
		data.removeAll { board in
			board.id == id
		}
	}
	
	func updateBoardsStates() async throws {
		let commands = data.map {
			Board.Command.boardState(boardID: $0.id)
		}
		
		try await send(commands)
	}
	
	func send(_ commands: [Board.Command]) async throws {
		for command in commands {
			try await send(command)
		}
	}
	
	@MainActor
	func send(_ command: Board.Command) async throws {
		switch command {
		case .pinOn(let pinID):
			let pin: Pin = self[pinID]
			let board: Board = self[pinID]
			try await boardConnection.setPinOn(pin, on: board)
			
		case .pinOff(let pinID):
			let pin: Pin = self[pinID]
			let board: Board = self[pinID]
			try await boardConnection.setPinOff(pin, on: board)
			
		case .boardState(let boardID):
			guard let boardIndex = data.firstIndex(where: { $0.id == boardID }) else { return }
			let board: Board = self[boardID]
			
			let state = await boardConnection.getState(of: board)
			
			data[boardIndex].state = state
			
		case .pinState(let pinID):
			let pin: Pin = self[pinID]
			let board: Board = self[pinID]
			guard
				let boardIndex = data.firstIndex(where: { $0.id == board.id }),
				let pinIndex = board.pins.firstIndex(where: { $0.id == pinID })
			else { return }
			
			let state = try! await boardConnection.getState(of: pin, on: board)
			
			data[boardIndex].pins[pinIndex].state = state
		}
	}
}

