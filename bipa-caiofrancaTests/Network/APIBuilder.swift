//
//  APIBuilder.swift
//  bipa-caiofranca
//
//  Created by Caio França on 05/02/25.
//

import XCTest
@testable import bipa_caiofranca

final class APIBuilder: API {
    
    var headers: [String : String]? {
        return nil
    }
    
    var scheme: HTTPScheme {
        .https
    }
    
    var baseURL: String
    var path: String
    var parameters: [URLQueryItem]
    var method: HTTPMethod
    
    init(baseURL: String = "test.com", path: String, parameters: [URLQueryItem] = [], method: HTTPMethod) {
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
        self.method = method
    }
}
