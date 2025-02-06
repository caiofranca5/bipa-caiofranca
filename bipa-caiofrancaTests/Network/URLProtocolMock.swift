//
//  URLProtocolMock.swift
//  bipa-caiofranca
//
//  Created by Caio França on 05/02/25.
//

import XCTest
@testable import bipa_caiofranca

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url,
           let data = URLProtocolMock.testURLs[url] {
            client?.urlProtocol(self, didLoad: data)
        }

        if let response = URLProtocolMock.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let error = URLProtocolMock.error {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
