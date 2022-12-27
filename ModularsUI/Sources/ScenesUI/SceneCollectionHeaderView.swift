//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 06.06.22.
//

import SwiftUI
import DataTypes
import Repositories
import Constants


struct SceneCollectionHeaderView: View {
	
	let sceneCollection: SceneCollection
	@EnvironmentObject private var sceneRepository: SceneRepository
	@EnvironmentObject private var sceneCollectionRepository: SceneCollectionRepository

//	@State private var showDeleteCollectionAlert = false
//	@State private var showDeleteSceneAlert = false
	@Binding var collectionToDelete: SceneCollection?
	
    var body: some View {
		HStack(alignment: .center, spacing: 8.0) {
			if let icon = sceneCollection.iconName {
				Image(systemName: icon)
					.font(.system(.title2, design: .rounded).bold())
					.tint(Color.accent)
			}
			Text(sceneCollection.name)
				.font(.system(.title2, design: .rounded).bold())
				.foregroundColor(.primary)
			Spacer()
			Menu {
				Button {
					sceneRepository.createNewScene(in: sceneCollection.id)
					
				} label: {
					Label("Neue Szene", systemImage: "plus")
				}
				Button {
					
				} label: {
					Label("Sammlung bearbeiten", systemImage: "play.rectangle.fill")
				}
				Button(role: .destructive) {
					collectionToDelete = sceneCollection
				} label: {
					Label("Sammlung löschen", systemImage: "trash")
				}
			} label: {
				Image(systemName: "ellipsis.circle.fill")
					.font(.title2.bold())
					.symbolRenderingMode(.hierarchical)
			}
		}
		.padding()
//		.alert("Sammlung löschen", isPresented: $showDeleteCollectionAlert) {
//			Button {
//				showDeleteSceneAlert = false
//			} label: {
//				Label("Abbrechen", systemImage: "play.rectangle.fill")
//			}
//			Button(role: .destructive) {
//				showDeleteSceneAlert = false
//				sceneCollectionRepository.deleteSceneCollection(with: sceneCollection.id)
//			} label: {
//				Label("Löschen", systemImage: "trash")
//			}
//		}
    }
}

struct SceneCollectionHeaderView_Previews: PreviewProvider {
	
	
    static var previews: some View {
		SceneCollectionHeaderView(
			sceneCollection: SceneCollection(name: "Collection 2"),
			collectionToDelete: .constant(SceneCollection(name: "Collection 2"))
		)
			.padding()
			.background(Color(white: 0.95, opacity: 1.0))
			.previewLayout(.fixed(width: 400, height: 70))
    }
}
