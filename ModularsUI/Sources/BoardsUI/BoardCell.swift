//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import SwiftUI
import DataTypes
import Constants



struct BoardCell: View {
	let board: Board
	
    var body: some View {
		VStack(spacing: 32) {
			Image(systemName: "cpu")
				.font(.largeTitle)
				.padding(.top)
			HStack(alignment: .center, spacing: 2) {
				VStack(alignment: .leading, spacing: 4) {
					Text(board.name)
						.font(.system(.title3, design: .rounded)).bold()
						.foregroundColor(.primary)
						.lineLimit(1)
					Text(board.address)
					 .font(.subheadline).bold()
					 .foregroundColor(.secondary)
				}
				Spacer()
				board.state
					.frame(width: 20, height: 20)
			}
		}
		.padding(12)
		.background(Color.secondaryBackground
			.cornerRadius(12)
			.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 3)
		)
	}
}

struct BoardCell_Previews: PreviewProvider {
	static let previewData: [Board] = [
		Board(address: "127.0.0.1", name: "Board 1", state: .online),
		Board(address: "127.0.0.1", name: "Board 2", state: .offline),
		Board(address: "127.0.0.1", name: "Board 3", state: .unknown),
	]
	
    static var previews: some View {
		Group {
			BoardCell(board: previewData[0])
			BoardCell(board: previewData[1])
			BoardCell(board: previewData[2])
		}
		.padding()
		.background(Color.primaryBackground)
		.previewLayout(.fixed(width: 200, height: 200))
    }
}
