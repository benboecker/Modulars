//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import SwiftUI

struct LEDView: View {
	
	let color: Color
	
    var body: some View {
        Text("Hello, World!")
    }
}

struct LEDView_Previews: PreviewProvider {
    static var previews: some View {
		LEDView(color: .red)
    }
}
