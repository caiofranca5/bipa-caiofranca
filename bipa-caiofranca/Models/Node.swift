//
//  Node.swift
//  bipa-caiofranca
//
//  Created by Caio França on 03/02/25.
//

struct Node: Decodable {
    let publicKey: String?
    let alias: String?
    let channels: Double?
    let capacity: Double?
    let firstSeen: Int?
    let updatedAt: Int?
    let city: NodeLocation?
    let country: NodeLocation?
    
    enum CodingKeys: String, CodingKey {
        case publicKey
        case alias
        case channels
        case capacity
        case firstSeen
        case updatedAt
        case city
        case country
    }
}
