//
//  NodesViewModelTests.swift
//  bipa-caiofrancaTests
//
//  Created by Caio França on 05/02/25.
//

import XCTest

import XCTest
@testable import bipa_caiofranca

final class NetworkManagerStub: NetworkManagerProtocol {
    var session: URLSession = URLSession.shared
    
    func request<T>(endpoint: any bipa_caiofranca.API) async throws -> T where T : Decodable {
        throw NetworkError.unknown
    }
}

@MainActor
final class NodesViewModelTests: XCTestCase {

    func testNodeCapacityInBTC() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let node = Node(
            publicKey: nil,
            alias: nil,
            channels: nil,
            capacity: 210_000_000,
            firstSeen: nil,
            updatedAt: nil,
            city: nil,
            country: nil
        )
        let result = sut.nodeCapacityInBTC(node)
        XCTAssertEqual(result, "2.10000000 BTC")
    }

    func testLocalizedName_withPortuguese() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let location = NodeLocation(ptBR: "São Paulo", en: "Sao Paulo")
        let result = sut.localizedName(location)
        XCTAssertEqual(result, "São Paulo")
    }

    func testLocalizedName_withEnglish() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let location = NodeLocation(ptBR: nil, en: "New York")
        let result = sut.localizedName(location)
        XCTAssertEqual(result, "New York")
    }

    func testLocalizedName_empty() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let location = NodeLocation(ptBR: nil, en: nil)
        let result = sut.localizedName(location)
        XCTAssertEqual(result, "")
    }

    func testNodeLocation_withValidData() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let node = Node(
            publicKey: nil,
            alias: nil,
            channels: nil,
            capacity: nil,
            firstSeen: nil,
            updatedAt: nil,
            city: NodeLocation(ptBR: "São Paulo", en: "Sao Paulo"),
            country: NodeLocation(ptBR: "Brasil", en: "Brazil")
        )
        let result = sut.nodeLocation(node)
        XCTAssertEqual(result, "São Paulo, Brasil")
    }

    func testNodeLocation_withNilCityAndCountry() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let node = Node(
            publicKey: nil,
            alias: nil,
            channels: nil,
            capacity: nil,
            firstSeen: nil,
            updatedAt: nil,
            city: nil,
            country: nil
        )
        let result = sut.nodeLocation(node)
        XCTAssertEqual(result, "Desconhecido, País Desconhecidu")
    }

    func testNodeDate_validTimestamp() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let someUnixTimestamp = 1_700_000_000
        let result = sut.nodeDate(someUnixTimestamp)
        XCTAssertFalse(result.isEmpty)
    }

    func testNodeDate_nilTimestamp() {
        let sut = NodesByConnectivityViewModel(networkManager: NetworkManagerStub())
        let result = sut.nodeDate(nil)
        XCTAssertEqual(result, "-")
    }
}

