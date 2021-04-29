//
//  AcronymsList.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import SwiftUI

struct AcronymsListView: View {
    private let titleSize: CGFloat = 25
    private let mainSpacing: CGFloat = 8
    
    @ObservedObject private var viewModel:AcronymSearchViewModel
    @State private var searchText = ""

    init(viewModel: AcronymSearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: mainSpacing, content: {
            SearchBar(text: $searchText)
            Button("Search") {
                viewModel.getAcronyms(keyword: searchText)
            }
            if viewModel.acronyms.isEmpty {
                Text("Search something!")
            } else {
                List(viewModel.acronyms) { acronym in
                    VStack(alignment: .leading) {
                        Text(acronym.sf ?? "")
                            .font(.system(size: titleSize)).fontWeight(.bold)
                        ForEach(acronym.lfs ?? []) { meaning in
                            MeaningView(meaning: meaning).padding(mainSpacing)
                        }
                    }
                }.gesture(DragGesture().onChanged { _ in
                    UIApplication.shared.endEditing(true)
                })
            }
            Spacer()
        })
    }
}
