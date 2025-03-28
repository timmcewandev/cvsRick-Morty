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
    
    func fetchCharacters() async throws {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/name=\(searchText)") else {
           return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let charactersData = try decoder.decode(CharacterResponse.self, from: data)
            await MainActor.run {
                self.characters = charactersData.result
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
