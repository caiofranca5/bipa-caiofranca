//
//  NodeLocation.swift
//  bipa-caiofranca
//
//  Created by Caio França on 04/02/25.
//

struct NodeLocation: Decodable {
    let ptBR: String?
    let en: String?

    enum CodingKeys: String, CodingKey {
        case ptBR = "pt-BR"
        case en
    }
}
