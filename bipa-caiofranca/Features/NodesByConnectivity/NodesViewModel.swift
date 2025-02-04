//
//  NodesViewModel.swift
//  bipa-caiofranca
//
//  Created by Caio França on 03/02/25.
//

import SwiftUI

@MainActor
final class NodesByConnectivityViewModel: ObservableObject {
    @Published var nodes: [Node] = []
    @Published var errorMessage: String? = nil
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchNodes() async {
        do {
            self.nodes = try await networkManager.request(endpoint: Mempool.nodesByConnectivity)
        } catch let error as NetworkError {
            self.errorMessage = error.description
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
}
