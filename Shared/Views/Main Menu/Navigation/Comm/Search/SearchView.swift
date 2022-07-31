//
//  SearchView.swift
//  Meliora
//
//  Created by Yura on 7/31/22.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.isSearching) private var isSearching
    
    @ViewBuilder var body: some View {
        if isSearching {
            SearchHistoryView()
        } else {
            SocialSuggestions()
        }
    }
    
    struct SearchHistoryView: View {
        var body: some View {
            List {
                Section {
                    
                } header: {
                    Text("History")
                }

            }
        }
    }
    
    struct SocialSuggestions: View {
        var body: some View {
            Text("Idle")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
