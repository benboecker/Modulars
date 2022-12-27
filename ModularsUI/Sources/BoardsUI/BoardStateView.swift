//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import DataTypes
import SwiftUI
import SharedUI



extension Board.State: View {
	public var body: some View {
		Circle()
			.foregroundColor(color)
	}
	
	private var color: Color {
		switch self {
		case .online: return .green
		case .offline: return .red
		case .unknown: return .gray
		}
	}
}


struct Board_State_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Board.State.online
			Board.State.offline
			Board.State.unknown
		}
		.padding()
		.previewLayout(.fixed(width: 50, height: 50))
	}
}
