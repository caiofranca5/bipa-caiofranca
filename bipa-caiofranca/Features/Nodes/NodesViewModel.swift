//
//  NodesViewModel.swift
//  bipa-caiofranca
//
//  Created by Caio França on 03/02/25.
//

import SwiftUI

final class NodesViewModel: ObservableObject {
    @Published var nodes: [Node] = []
}
