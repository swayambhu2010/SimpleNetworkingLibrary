//
//  ResponseDecoder.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

public protocol ResponseDecoder {
    func decodeResponse<T: Decodable>(type: T.Type, data: Data) throws -> T?
}

public class ResponseObject: ResponseDecoder {
    public func decodeResponse<T>(type: T.Type, data: Data) throws -> T? where T : Decodable {
        let decoder = JSONDecoder()
        let data = try decoder.decode(type, from: data)
        return data
    }
}
