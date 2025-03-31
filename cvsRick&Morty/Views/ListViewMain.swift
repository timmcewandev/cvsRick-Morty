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
    @State private var selectedCharacter: CharacterDetail?
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
                        ListView(name: c.name, species: c.species, imagageURL: c.image) {
                            selectedCharacter = c
                        }
                    }
                    
                    
                })
                
            }
            
        }
        .searchable(text: $oo.searchText, isPresented: $isTextPresented, prompt: "search")
        .onChange(of: oo.searchText) { newValue in
            oo.searchCharacters(newText: newValue)
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
        .sheet(item: $selectedCharacter) { character in
            DetailView(character: character)
                .presentationDetents([.fraction(0.80)])
        }
    }
}

#Preview {
    ListViewMain()
}
