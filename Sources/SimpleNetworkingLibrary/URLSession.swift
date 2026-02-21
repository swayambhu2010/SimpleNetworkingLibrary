//
//  URLSession.swift
//  System Design
//
//  Created by Swayambhu BANERJEE on 21/01/26.
//

import Foundation
import Alamofire

public protocol SessionManager {
    func execute(url: URLRequest) async throws -> (Data, URLResponse)
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public class RequestSession: SessionManager {
    public init() {}
    
    public func execute(url: URLRequest) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: url)
    }
}

class AlamofireHTTPClient: SessionManager {
    
    let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func execute(url: URLRequest) async throws -> (Data, URLResponse) {
        let afResponse = await session
            .request(url)
            .serializingData(emptyResponseCodes: [200, 204, 205])
            .response                                           // AFDataResponse<Data>
        
        // Step 2: If Alamofire produced an error, throw it
        if let error = afResponse.error {
            throw error
        }
        
        if let data = afResponse.data, let resp = afResponse.response {
            // Step 3: Return (Data?, URLResponse?) to match the protocol
            return (data, resp)
        }
        return (Data(), URLResponse())
    }
}
