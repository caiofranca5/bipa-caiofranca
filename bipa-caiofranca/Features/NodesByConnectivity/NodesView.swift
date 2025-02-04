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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                await viewModel.fetchNodes()
            }
    }
}

#Preview {
    NodesByConnectivityView()
}
