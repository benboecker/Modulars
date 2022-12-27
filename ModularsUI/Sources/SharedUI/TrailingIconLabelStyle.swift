//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 14.07.22.
//

import Foundation
import SwiftUI


// Make a struct that conforms to the LabelStyle protocol,
//and return a view that has the title and icon switched in a HStack
public struct TrailingIconLabelStyle: LabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.title
			configuration.icon
		}
	}
}

public extension LabelStyle where Self == TrailingIconLabelStyle {
	static var trailingIcon: Self {
		TrailingIconLabelStyle()
	}
}
