//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 06.06.22.
//

import Foundation
import PHNetworking
import DataTypes


struct BoardEndpoint: Endpoint {
	var baseURL: URL
	var path: String
	var parameters: [EndpointParameter]
	var headers: [Header]
	
	let scheme: String = "http"
}


extension BoardEndpoint {
	static func status(for address: String) -> BoardEndpoint {
		BoardEndpoint(
			baseURL: URL(string: address)!,
			path: "status",
			parameters: [],
			headers: []
		)
	}
	
	static func status(for address: String, pin: Int) -> BoardEndpoint {
		BoardEndpoint(
			baseURL: URL(string: address)!,
			path: "status",
			parameters: [],
			headers: []
		)
	}
	
	static func pinOn(for address: String, pin: Int) -> BoardEndpoint {
		BoardEndpoint(
			baseURL: URL(string: address)!,
			path: "led_on/\(pin)",
			parameters: [],
			headers: []
		)
	}
	
	static func pinOff(for address: String, pin: Int) -> BoardEndpoint {
		BoardEndpoint(
			baseURL: URL(string: address)!,
			path: "led_off/\(pin)",
			parameters: [],
			headers: []
		)
	}
}
