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
        NavigationStack(root: {
            List(viewModel.nodes, id: \.publicKey) { node in
                Section(header: Text(node.alias ?? "")) {
                    NodeRow(viewModel: self.viewModel, node: node)
                }
    
            }
            .navigationTitle("Nodes")
            .task {
                await viewModel.fetchNodes()
            }
        })
    }
}

fileprivate struct NodeRow: View {
    @ObservedObject var viewModel: NodesByConnectivityViewModel
    let node: Node
    
    var body: some View {
        VStack(spacing: 14, content: {
//            Text(node.alias ?? "")
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .font(.system(size: 22, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 8, content: {
                Label {
                    Text("Chave Pública")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "key.horizontal.fill")
                        .foregroundColor(.yellow)
                }
                //.labelStyle(.titleOnly)
                .font(.system(size: 17, weight: .medium))
                .lineLimit(1)
                
                Text(node.publicKey ?? "")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            })
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Label {
                    Text("Canais")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "link")
                        .foregroundColor(.gray)
                }
                .labelStyle(.titleOnly)
                .font(.system(size: 17, weight: .medium))
                .lineLimit(1)
                
                Text("\(node.channels ?? 0.0)")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
            })
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Label {
                    Text("Capacidade")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "bitcoinsign")
                        .foregroundColor(.orange)
                }
                .labelStyle(.titleOnly)
                .font(.system(size: 17, weight: .medium))
                .lineLimit(1)
                
                Text(viewModel.nodeCapacityInBTC(node))
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
            })
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Label {
                    Text("Primeira Aparição")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "calendar.badge.plus")
                        .symbolRenderingMode(.multicolor)
                }
                .labelStyle(.titleOnly)
                .font(.system(size: 17, weight: .medium))
                .lineLimit(1)
                
                Text("17/12/2025")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                    
            })
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Label {
                    Text("Atualizado em")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(.primary)
                }
//                .labelStyle(.titleOnly)
                .font(.system(size: 17, weight: .medium))
                .lineLimit(1)
                
                Text("17/12/2025")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                    
            })
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Label {
                    Text("Localização")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: "globe.americas.fill")
                        .foregroundColor(.primary)
                }
//                .labelStyle(.titleOnly)
                .font(.system(size: 17, weight: .semibold))
                .lineLimit(1)
                
                Text(viewModel.nodeLocation(node))
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.secondary)
                    
            })
        })
    }
}

#Preview {
    NodesByConnectivityView()
}
