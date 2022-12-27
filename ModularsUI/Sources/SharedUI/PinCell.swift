//
//  SwiftUIView.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import SwiftUI
import DataTypes
import Constants



public struct PinCell: View {
	private let pin: Pin
	private let light: Light?
	
	public init(pin: Pin, light: Light? = nil) {
		self.pin = pin
		self.light = light
	}
	
	public var body: some View {
		HStack {
			Text(pin.title)
				.foregroundColor(.primary)
				.font(.headline)
			Spacer()
			VStack(alignment: .trailing, spacing: 2) {
				Label(pin.gpio, systemImage: "cable.connector.horizontal")
					.labelStyle(.trailingIcon)
				Label("\(pin.internalNumber)", systemImage: "chevron.left.forwardslash.chevron.right")
					.labelStyle(.trailingIcon)
				if let light {
					Label(light.name, systemImage: "light.max")
						.font(.body.bold())
						.labelStyle(.trailingIcon)
						.foregroundColor(.accent)
				}
			}
			.font(.system(.subheadline, design: .monospaced))
			.foregroundColor(.secondary)
		}
	}
}

struct PinCell_Previews: PreviewProvider {
    static var previews: some View {
		PinCell(pin: Pin.allPins.first!)
			.padding()
			.border(.black)
			.previewLayout(.fixed(width: 320, height: 84))
    }
}
