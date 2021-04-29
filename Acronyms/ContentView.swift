//
//  ContentView.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import Foundation

import SwiftUI

struct ContentView: View {
    var body: some View {
        AcronymsListView(viewModel:
                            AcronymSearchViewModel(service:
                                                    AcronymsNetworkService()))
    }
}
