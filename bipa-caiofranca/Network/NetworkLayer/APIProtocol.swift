//
//  API.swift
//  bipa-caiofranca
//
//  Created by Caio França on 03/02/25.
//

import Foundation

protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
}
