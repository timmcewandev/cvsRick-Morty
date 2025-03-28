//
//  ListDetailView.swift
//  cvsRick&Morty
//
//  Created by Tim McEwan on 3/28/25.
//

import SwiftUI

struct ListView: View {
    @State var name: String
    @State var species: String
    @State var imagageURL: String
    let tap: () -> Void
    var body: some View {
        LazyHStack {
            AsyncImage(url: URL(string: imagageURL)) { status in
                switch status {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                case .failure(let error):
                    ProgressView()
                        .task {
                            print("Error downloading image: \(error)")
                        }
                @unknown default:
                    EmptyView()
                }
            }
            LazyVStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(species)
                    .font(.caption)
                    
            }
            
            
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("name:\(name) species:\(species)"))
        .accessibility(hint: Text("Tap to view details"))
        .onTapGesture {
            tap()
        }
    }
}

//#Preview {
//    ListMainView()
//}
