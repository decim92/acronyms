//
//  MeaningList.swift
//  Acronyms
//
//  Created by Douglas Poveda on 28/04/21.
//

import SwiftUI

struct MeaningView: View {
    private var titleSize: CGFloat = 18
    private let subtitleSize: CGFloat = 16
    private let contentSize: CGFloat = 14
    private let mainSpacing: CGFloat = 8
    private var meaning: Meaning

    init(meaning: Meaning, titleSize: CGFloat? = nil) {
        self.meaning = meaning
        if let titleSize = titleSize {
            self.titleSize = titleSize
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(meaning.lf ?? "")
                .font(.system(size: titleSize)).fontWeight(.bold)
            Text("Frecuency: \(meaning.freq ?? 0)")
                .font(.system(size: contentSize))
            Text("Since: \(meaning.since ?? 0)")
                .font(.system(size: contentSize))
                if let vars = meaning.vars {
                    Text("Variants").padding(.top, mainSpacing)
                        .font(.system(size: subtitleSize))
                    ForEach(vars) { meaning in
                        MeaningView(meaning: meaning, titleSize: 15).padding(mainSpacing)
                    }
                }
        }
    }
}
