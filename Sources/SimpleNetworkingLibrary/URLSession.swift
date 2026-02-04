//
//  URLSession.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

public protocol SessionManager {
    func execute(url: URLRequest) async throws -> (Data, URLResponse)
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public class RequestSession: SessionManager {
    public func execute(url: URLRequest) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: url)
    }
}
