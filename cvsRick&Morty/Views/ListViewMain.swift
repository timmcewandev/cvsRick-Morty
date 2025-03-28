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
    var body: some View {
        NavigationStack {
            if oo.characters.isEmpty {
                Text("Loading...")
                ProgressView()
            } else {
                List(content: {
                    ForEach(oo.characters, id: \.id) { character in
                        let c = character
                        Text(c.name)
                        
                    }
                })
                //                })
            }
        }
        .task {
            do {
                try await oo.fetchCharacters()
                print(oo.characters.count)
            } catch(let error) {
                print("Error fetching characters: \(error.localizedDescription)")
            }
            
        }
    }
    
}

#Preview {
    ListViewMain()
}
