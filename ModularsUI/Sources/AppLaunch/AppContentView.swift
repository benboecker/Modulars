//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import SwiftUI
import BoardsUI
import ScenesUI
import BuildingsUI
import Repositories
import LightsUI



public struct AppContentView: View {
	@StateObject private var store = Store()

	@Environment(\.scenePhase) private var scenePhase

	public init() { }
	
	public var body: some View {
		TabView {
//			BuildingsView()
			ScenesView()
			LightsView()
			BoardsView()
		}
		.environmentObject(store.boardsRepository)
		.environmentObject(store.scenesRepository)
		.environmentObject(store.lightsRepository)
		.environmentObject(store.sceneCollectionsRepository)
		.onChange(of: scenePhase) { phase in
			guard phase == .inactive else { return }
			Task {
				try await store.saveData()
			}
		}
		.task {
			do {
				try await store.loadData()
			} catch {
				
			}
		}
	}
	
}

struct AppContentView_Previews: PreviewProvider {
	static var previews: some View {
		AppContentView()
	}
}
