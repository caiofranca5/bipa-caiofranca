//
//  Song.swift
//  bipa-caiofranca
//
//  Created by Caio França on 04/01/25.
//


import XCTest
@testable import bipa_caiofranca

struct Song: Decodable {
    let title: String
    let rating: Int
}
