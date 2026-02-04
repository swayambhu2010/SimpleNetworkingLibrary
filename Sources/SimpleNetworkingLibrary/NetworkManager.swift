//
//  NetworkManager.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

protocol NetworkRequest {
    func request<T:Decodable>(apiRequest: APIEndPoint) async throws -> T?
}

class NetworkService: NetworkRequest {
    
    private var requestBuilder: RequestBuilder
    private var sessionManager: RequestSession
    private var decoder: ResponseObject
    
    init(requestBuilder: RequestBuilder, sessionManager: RequestSession, decoder: ResponseObject) {
        self.requestBuilder = requestBuilder
        self.sessionManager = sessionManager
        self.decoder = decoder
    }
    
    func request<T: Decodable>(apiRequest: APIEndPoint) async throws -> T? {
        guard let url = requestBuilder.createRequest(request: apiRequest) else { return nil }
        let (data, response) = try await sessionManager.execute(url: url)
        let obj = try decoder.decodeResponse(type: T.self, data: data)
        return obj
    }
}
