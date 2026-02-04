//
//  URLSession.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

protocol SessionManager {
    func execute(url: URLRequest) async throws -> (Data, URLResponse)
}

class RequestSession: SessionManager {
    func execute(url: URLRequest) async throws -> (Data, URLResponse) {
         try await URLSession.shared.data(for: url)
    }
}
