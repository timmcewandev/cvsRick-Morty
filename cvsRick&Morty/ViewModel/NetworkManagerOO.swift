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
    let debounceInterval: Double = 3 
    func fetchCharacters(searchText: String) async throws {
        // Debounce the API call no avoid api calls with search keystroke. I personally think 3 seconds should be enough.
        try? await Task.sleep(nanoseconds: UInt64(debounceInterval * 1_000_000_000))
        
        // Check if the task was cancelled during the sleep
        if Task.isCancelled { return }
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
    
}

enum NetworkError: Error {
    case invalidURL
    case dataTaskFailed
    case decodingFailed
}
