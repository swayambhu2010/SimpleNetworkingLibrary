//
//  ResponseDecoder.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation

protocol ResponseDecoder {
    func decodeResponse<T: Decodable>(type: T.Type, data: Data) throws -> T?
}

class ResponseObject: ResponseDecoder {
    func decodeResponse<T>(type: T.Type, data: Data) throws -> T? where T : Decodable {
        let decoder = JSONDecoder()
        let data = try decoder.decode(type, from: data)
        return data
    }
}
