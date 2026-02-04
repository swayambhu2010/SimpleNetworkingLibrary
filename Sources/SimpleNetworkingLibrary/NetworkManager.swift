//
//  NetworkManager.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

public protocol NetworkRequest {
    func request<T:Decodable>(apiRequest: APIEndPoint) async throws -> T?
}

public class NetworkService: NetworkRequest {
    
    private var requestBuilder: RequestBuilder
    private var sessionManager: RequestSession
    private var decoder: ResponseObject
    
    public init(requestBuilder: RequestBuilder, sessionManager: RequestSession, decoder: ResponseObject) {
        self.requestBuilder = requestBuilder
        self.sessionManager = sessionManager
        self.decoder = decoder
    }
    
    public convenience init() {
        self.init(
            requestBuilder: RequestBuilder(),
            sessionManager: RequestSession(),
            decoder: ResponseObject()
        )
    }
    
    public func request<T: Decodable>(apiRequest: APIEndPoint) async throws -> T? {
        guard let url = requestBuilder.createRequest(request: apiRequest) else { return nil }
        let (data, _) = try await sessionManager.execute(url: url)
        let obj = try decoder.decodeResponse(type: T.self, data: data)
        return obj
    }
}
