//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 01.06.22.
//

import Foundation
import UIKit
import SwiftUI


public extension Color {
	static let primaryBackground = Color(uiColor: .primaryBackground)
	static let secondaryBackground = Color(uiColor: .secondaryBackground)
	
	static let primaryText = Color(uiColor: .primaryText)
	static let secondaryText = Color(uiColor: .secondaryText)

	static let accent = Color(uiColor: .accent)
	static let lightOn = Color(uiColor: .lightOn)
}


extension UIColor {
	static let primaryBackground = UIColor(light: 0x000000, dark: 0x000000)
	static let secondaryBackground = UIColor(light: 0x1F1F1F, dark: 0x1F1F1F)
	static let primaryText = UIColor(light: 0xFFFFFF, dark: 0xFFFFFF)
	static let secondaryText = UIColor(light: 0xDDDDDD, dark: 0xDDDDDD)
	static let accent = UIColor(light: 0xBF40BF, dark: 0xBF40BF)
	static let lightOn = UIColor(light: 0xEEEEFF, dark: 0xFCEEA7)

	
	convenience init(hex: Int, alpha: CGFloat = 1.0) {
		let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
		let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
		let blue = CGFloat((hex & 0xFF)) / 255.0
		
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	convenience init(light: Int, dark: Int) {
		self.init(dynamicProvider: { traitCollection -> UIColor in
			switch traitCollection.userInterfaceStyle {
			case .dark: return UIColor(hex: dark)
			case .light: return UIColor(hex: light)
			case .unspecified: return UIColor(hex: light)
			@unknown default: return UIColor(hex: light)
			}
		})
	}
}
