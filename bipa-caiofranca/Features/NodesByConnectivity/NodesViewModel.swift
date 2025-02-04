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
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchNodes() async {
        do {
            self.nodes = try await networkManager.request(endpoint: Mempool.nodesByConnectivity)
            print(nodes)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
