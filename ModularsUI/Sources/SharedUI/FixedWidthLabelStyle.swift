//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import SwiftUI



public struct FixedWidthLabelStyle: LabelStyle {
	public init() { }
	
	
	@ViewBuilder
	public func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon
				.frame(minWidth: 30, alignment: .trailing)
			configuration.title
		}
	}
}
