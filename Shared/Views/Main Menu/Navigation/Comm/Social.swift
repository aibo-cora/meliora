//
//  Social.swift
//  Meliora
//
//  Created by Yura on 7/29/22.
//

import SwiftUI

struct Social: View {
    @StateObject private var viewModel = SocialViewModel()
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchView()
            }
            .searchable(text: $text, prompt: "Find friends")
            .navigationTitle("Community")
        }
        .navigationViewStyle(.stack)
    }
}

struct Social_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Social()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
        }
    }
}
