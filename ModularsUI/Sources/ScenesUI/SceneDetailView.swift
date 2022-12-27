//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 06.06.22.
//

import SwiftUI
import DataTypes
import Repositories


struct SceneDetailView: View {
	
	let scene: DataTypes.Scene
	
	@EnvironmentObject private var sceneRepository: SceneRepository
	@EnvironmentObject private var sceneCollectionRepository: SceneCollectionRepository

	
    var body: some View {
        Text("Hello, World!")
    }
}


struct SceneDetailView_Previews: PreviewProvider {
	static let previewData = DataTypes.Scene(
		title: "Szene 1",
		collectionID: SceneCollection(name: "").id
	)

    static var previews: some View {
		SceneDetailView(scene: previewData)
    }
}
