//
//  APIRequest.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
}


public protocol APIEndPoint {
    var schema: String { get }
    var baseURL: String { get }
    var path: String { get }
    var queryParams: [URLQueryItem] { get }
    
    var header: [String: String] { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    
}

public protocol BaseRequest {
    func createRequest(request: APIEndPoint) -> URLRequest?
}

public class RequestBuilder: BaseRequest {
    public func createRequest(request: APIEndPoint) -> URLRequest? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = request.baseURL
        component.path = request.path
        component.queryItems = request.queryParams
        
        guard let url = component.url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.method.rawValue
        request.header.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpBody = request.body
        return urlRequest
    }
}
