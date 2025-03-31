//
//  NetworkManagerOO.swift
//  cvsRick&Morty
//
//  Created by Tim McEwan on 3/28/25.
//

import Foundation


class NetworkManagerOO: ObservableObject {
    @Published var characters: [CharacterDetail] = []
    @Published var searchText: String = "rick"
    private var searchDebounce: Timer?
    let debounceInterval: Double = 3
    
    deinit {
        searchDebounce?.invalidate()
    }
    
    func fetchCharacters(searchText: String) async throws {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(searchText)") else {
           return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let charactersData = try decoder.decode(CharacterResponse.self, from: data)
            await MainActor.run {
                self.characters = charactersData.results
            }
        } catch {
        }
    }
    
    func searchCharacters(newText: String) {
        searchDebounce?.invalidate()
        searchDebounce = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            Task {
                try? await self.fetchCharacters(searchText: newText)
            }
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case dataTaskFailed
    case decodingFailed
}
