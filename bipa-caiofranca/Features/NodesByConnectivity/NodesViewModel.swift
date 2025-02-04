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
            print(error.description)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func nodeCapacityInBTC(_ node: Node) -> String {
        let sats = node.capacity ?? 0.0
        let btcValue = sats / 100_000_000.0
        return String(format: "%.8f", btcValue) + " BTC"
    }
    
    func localizedName(_ location: NodeLocation) -> String {
        if let nameInPortuguese = location.ptBR {
            return nameInPortuguese
        } else if let nameInEnglish = location.en {
            return nameInEnglish
        } else {
            return ""
        }
    }
    
    func nodeLocation(_ node: Node) -> String {
        let city = node.city ?? NodeLocation(ptBR: "Desconhecido", en: "Unknown City")
        let country = node.country ?? NodeLocation(ptBR: "País Desconhecidu", en: "Unknown Country")
        
        return "\(localizedName(city)), \(localizedName(country))"
    }
    
}
