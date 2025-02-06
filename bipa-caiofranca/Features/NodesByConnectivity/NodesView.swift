//
//  NodesView.swift
//  bipa-caiofranca
//
//  Created by Caio França on 03/02/25.
//

import SwiftUI

struct NodesByConnectivityView: View {
    @StateObject var viewModel = NodesByConnectivityViewModel(networkManager: NetworkManager())
    
    var body: some View {
        NavigationStack {
            Group {
                if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label("Nenhum Resultado", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(errorMessage)
                    }
                } else {
                    if viewModel.nodes.isEmpty {
                        ProgressView("Carregando...")
                    } else {
                        List(viewModel.nodes, id: \.publicKey) { node in
                            Section(header: Text(node.alias ?? "")) {
                                NodeRow(viewModel: viewModel, node: node)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .refreshable {
                            await viewModel.fetchNodes()
                        }
                    }
                }
            }
            .navigationTitle("Nodes")
            .task {
                await viewModel.fetchNodes()
            }
        }
    }
}

fileprivate struct NodeRow: View {
    @ObservedObject var viewModel: NodesByConnectivityViewModel
    let node: Node

    var body: some View {
        VStack(spacing: 14) {
            NavigationLink(destination: {
                List(content: {
                    Section(header: Text("Public Key")) {
                        Text(node.publicKey ?? "")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.primary)
                    }
                    
                })
            }, label: {
                NodeRowItem(
                    title: "Chave Pública",
                    value: node.publicKey ?? ""
                )
            })
            
            Divider()

            NodeRowItem(
                title: "Canais",
                value: "\(node.channels ?? 0)"
            )
            
            Divider()

            NodeRowItem(
                title: "Capacidade",
                value: viewModel.nodeCapacityInBTC(node)
            )
            
            Divider()

            NodeRowItem(
                title: "Primeira Aparição",
                value: viewModel.nodeDate(node.firstSeen)
            )
            
            Divider()

            NodeRowItem(
                title: "Atualizado em",
                value: viewModel.nodeDate(node.updatedAt)
            )
            
            Divider()

            NodeRowItem(
                title: "Localização",
                value: viewModel.nodeLocation(node)
            )
        }
    }
}

fileprivate struct NodeRowItem: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.primary)

            Text(value)
                .font(.system(size: 17, weight: .regular))
                .lineLimit(1)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NodesByConnectivityView()
}
