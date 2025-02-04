//
//  Mempool.swift
//  bipa-caiofranca
//
//  Created by Caio França on 03/02/25.
//

import Foundation

enum Mempool: API {
    
    case nodesByConnectivity
    
    var baseURL: String {
        return "mempool.space"
    }
    
    var path: String {
        switch self {
        case .nodesByConnectivity:
            return "/api/v1/lightning/nodes/rankings/connectivity"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var parameters: [URLQueryItem] {
        return []
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
