//
//  Character.swift
//  cvsRick&Morty
//
//  Created by Tim McEwan on 3/28/25.
//

import Foundation


struct CharacterResponse: Decodable {
    let result: [CharacterDetail]
}
struct CharacterDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Origin
    let image: String
    let url: String
    let created: String
}

struct Origin: Decodable {
    let name: String
    let url: String
}
