//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 31.05.22.
//

import SwiftUI

public struct BuildingsView: View {
	
	
	public init() { }

	
	public var body: some View {
        Text("Hello, World!")
			.tabItem {
				   Label("Buildings", systemImage: "house")
			   }
    }
}

struct BuildingsView_Previews: PreviewProvider {
    static var previews: some View {
		BuildingsView()
    }
}
