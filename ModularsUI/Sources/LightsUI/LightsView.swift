//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import SwiftUI
import DataTypes
import Repositories
import Constants


public struct LightsView: View {
	@EnvironmentObject var lightsRepository: LightsRepository
	@EnvironmentObject var boardsRepository: BoardsRepository

	public init() {
		UITableView.appearance().backgroundColor = UIColor(.primaryBackground)
	}
	@State private var showingDeleteAlert = false
	@State private var lightIDToDelete: Light.ID?

	public var body: some View {
		NavigationView {
			List($lightsRepository.data) { $light in
				NavigationLink {
					LightDetailView(light: $light)
				} label: {
					LightRow(light: light)
				}
				.listRowBackground(Color.secondaryBackground)
				.swipeActions {
					Button("Delete", role: .destructive) {
						lightIDToDelete = light.id
						showingDeleteAlert = true
					}
				}
			}
			.alert("Light löschen?", isPresented: $showingDeleteAlert) {
				Button("Abbrechen", role: .cancel) {
					showingDeleteAlert = false
				}
				Button("Löschen", role: .destructive) {
					showingDeleteAlert = false
					guard let lightIDToDelete else { return }
					withAnimation {
						lightsRepository.deleteLight(with: lightIDToDelete)
						self.lightIDToDelete = nil
					}
				}
			}
			.navigationTitle("Lights")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						lightsRepository.createNewLight()
					} label: {
						Image(systemName: "plus.circle.fill")
							.font(.title2.bold())
							.symbolRenderingMode(.hierarchical)
					}
				}
			}
		}
		.tabItem {
			Label("Lights", systemImage: "lightbulb")
		}
	}
}


struct LightsView_Previews: PreviewProvider {
	static var previews: some View {
		LightsView()
			.environmentObject(LightsRepository())
    }
}
