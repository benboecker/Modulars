//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 11.07.22.
//

import Foundation


public class Store: ObservableObject {
	@Published public var boardsRepository = BoardsRepository()
	@Published public var scenesRepository = SceneRepository()
	@Published public var lightsRepository = LightsRepository()
	@Published public var sceneCollectionsRepository = SceneCollectionRepository()

	public init() {
		lightsRepository.boardsRepository = boardsRepository
		scenesRepository.lightRepository = lightsRepository
	}
}

public extension Store {
	func saveData() async throws {
		try await boardsRepository.save()
		try await scenesRepository.save()
		try await lightsRepository.save()
		try await sceneCollectionsRepository.save()
	}
	
	@MainActor
	func loadData() async throws {
		let boards = try await boardsRepository.loadData()
		boardsRepository.data = boards
		
		let scenes = try await scenesRepository.loadData()
		scenesRepository.data = scenes
		
		let lights = try await lightsRepository.loadData()
		lightsRepository.data = lights
		
		let sceneCollections = try await sceneCollectionsRepository.loadData()
		sceneCollectionsRepository.data = sceneCollections
	}
}
