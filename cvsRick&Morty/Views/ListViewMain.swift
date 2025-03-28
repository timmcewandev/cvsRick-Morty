//
//  ListViewMain.swift
//  cvsRick&Morty
//
//  Created by Tim McEwan on 3/28/25.
//

import SwiftUI
import Combine

struct ListViewMain: View {
    @StateObject private var oo = NetworkManagerOO()
    @State private var selectedCharacter: Character?
    @State private var isTextPresented: Bool = false
    var body: some View {
        NavigationStack {
            if oo.characters.isEmpty {
                Text("Loading...")
                ProgressView()
            } else {
                List(content: {
                    ForEach(oo.characters, id: \.id) { character in
                        let c = character
                        ListMainView(name: c.name, species: c.species, imagageURL: c.image) {
                        }
                    }
                })
            }
            
        }
        .searchable(text: $oo.searchText, isPresented: $isTextPresented, prompt: "search")
        .onChange(of: oo.searchText) { newValue in
            oo.searchText = newValue
            Task {
                try? await oo.fetchCharacters(searchText: newValue)
            }
        }
        .refreshable {
            try? await oo.fetchCharacters(searchText: oo.searchText)
        }
        .task {
            do {
                try await oo.fetchCharacters(searchText: oo.searchText)
            } catch {
                print("Error fetching characters: \(error)")
            }
        }
    }
}

#Preview {
    ListViewMain()
}
