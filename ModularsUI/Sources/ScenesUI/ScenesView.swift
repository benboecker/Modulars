//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import SwiftUI
import Repositories
import DataTypes



public struct ScenesView: View {
	@EnvironmentObject private var sceneCollectionRepository: SceneCollectionRepository
	@EnvironmentObject private var sceneRepository: SceneRepository
	
	@State private var collectionToDelete: SceneCollection? = nil
	
	public init() { }
	
	private let columns: [GridItem] = [
		GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 8),
	]

	public var body: some View {
		NavigationView {
			ScrollView {
				LazyVGrid(columns: columns) {
					ForEach($sceneCollectionRepository.data) { sceneCollection in
						Section {
							ForEach($sceneRepository.data.filter({ $0.wrappedValue.collectionID == sceneCollection.id })) { scene in
								SceneCell(scene: scene)
							}
						} header: {
							SceneCollectionHeaderView(
								sceneCollection: sceneCollection.wrappedValue,
								collectionToDelete: $collectionToDelete
							)
						}
						.textCase(nil)
					}
				}
				.padding(.top)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						sceneCollectionRepository.createSceneCollection()
					} label: {
						Image(systemName: "plus.circle.fill")
							.font(.title2.bold())
							.symbolRenderingMode(.hierarchical)
					}
				}
			}
			.navigationTitle("Szenen")
			.alert(item: $collectionToDelete) { sceneCollection in
				Alert(
					title: Text("Löschen"),
					message: Text("Soll diese Sammlung gelöscht wirklich werden?"),
					primaryButton: .cancel(Text("Abbrechen")) {
						collectionToDelete = nil
					},
					secondaryButton: .destructive(Text("Löschen")) {
						withAnimation {
							sceneCollectionRepository.deleteSceneCollection(with: sceneCollection.id)
							sceneRepository.deleteScenes(in: sceneCollection.id)
						}
						collectionToDelete = nil
					}
				)
				
			}
		}
		.tabItem {
			Label("Scenes", systemImage: "play.rectangle")
		}
	}
}


struct ScenesView_Previews: PreviewProvider {
	static var previews: some View {
		ScenesView()
	}
}
