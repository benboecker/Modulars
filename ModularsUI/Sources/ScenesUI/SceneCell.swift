//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 06.06.22.
//

import SwiftUI
import DataTypes
import Constants
import Repositories


struct SceneCell: View {
	@Binding var scene: DataTypes.Scene
	@EnvironmentObject private var sceneRepository: SceneRepository

	
    var body: some View {
		HStack {
			if let iconName = scene.iconName {
				Image(systemName: iconName)
					.font(.title)
					.symbolRenderingMode(.hierarchical)
			}
			Text(scene.title)
				.font(.system(.headline, design: .rounded))
				.padding(6)
		}
		.foregroundColor((scene.isOn ? Color.black : Color.primary))
		.padding(8)
		.background((scene.isOn ? Color.lightOn : Color.secondaryBackground)
			.cornerRadius(12)
//			.shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
			
			.shadow(color: scene.isOn ? .lightOn.opacity(0.5) : .clear, radius: scene.isOn ? 10 : 0, x: 0, y: 3)
		)
		.onTapGesture {
			Task {
				try await sceneRepository.toggleScene(with: scene.id)
			}
		}

    }
}

struct SceneCell_Previews: PreviewProvider {
	
	static let previewData = DataTypes.Scene(
		title: "Szene 1",
		collectionID: SceneCollection(name: "").id
	)
	
    static var previews: some View {
		SceneCell(scene: .constant(previewData))
			.padding()
			.background(Color(white: 0.9, opacity: 1))
			.previewLayout(.fixed(width: 180, height: 100))
    }
}
