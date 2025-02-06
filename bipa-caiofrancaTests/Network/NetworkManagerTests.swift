//
//  NetworkManagerTests.swift
//  bipa-caiofranca
//
//  Created by Caio França on 05/02/25.
//

import XCTest
@testable import bipa_caiofranca

final class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        urlSession = URLSession(configuration: config)
        sut = NetworkManager(session: urlSession)
    }
    
    override func tearDown() {
        sut = nil
        urlSession = nil
        URLProtocolMock.testURLs = [:]
        URLProtocolMock.response = nil
        super.tearDown()
    }
    
    func testSuccessfulResponse() async throws {
        let baseURL = "test.com"
        let path = "/test"
        let fullURL = URL(string: "https://\(baseURL)\(path)?")!
        let testJSONData = """
            {
                "title": "Song Title",
                "rating": 5
            }
        """.data(using: .utf8)!
        URLProtocolMock.testURLs = [fullURL: testJSONData]
        URLProtocolMock.response = HTTPURLResponse(url: fullURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let testAPI = APIBuilder(baseURL: baseURL, path: path, method: .get)
        
        do {
            let result: Song = try await sut.request(endpoint: testAPI)
            XCTAssertEqual(result.title, "Song Title")
            XCTAssertEqual(result.rating, 5)
        } catch {
            XCTFail("Expected successful response, got \(error) instead")
        }
    }

    func testFailedResponse() async throws {
        let baseURL = "test.com"
        let path = "/test"
        let fullURL = URL(string: "https://\(baseURL)\(path)?")!
        let testJSONData = "{\"key\":\"value\"}".data(using: .utf8)!
        URLProtocolMock.testURLs = [fullURL: testJSONData]
        URLProtocolMock.response = HTTPURLResponse(url: fullURL, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let testAPI = APIBuilder(baseURL: baseURL, path: path, method: .get)
        
        do {
            let result: [String: String] = try await sut.request(endpoint: testAPI)
            XCTFail("Expected to throw error, but got result: \(result)")
        } catch NetworkError.badRequest {
            // Success
        } catch {
            XCTFail("Expected badRequest, got \(error) instead")
        }
    }
}

