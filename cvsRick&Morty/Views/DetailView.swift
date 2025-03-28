//
//  DetailView.swift
//  cvsRick&Morty
//
//  Created by Tim McEwan on 3/28/25.
//

import SwiftUI

struct DetailView: View {
    @State var character: CharacterDetail
    @State var date: Date?
    var body: some View {
        
        VStack {
            Text(character.name)
                .font(.largeTitle)
                .padding(.vertical)
            //Image - Full width
            AsyncImage(url: URL(string: character.image)) { status in
                switch status {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .frame( maxWidth: .infinity, maxHeight: 400)
                        .aspectRatio(contentMode: .fill)
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
            HStack(spacing: 1) {
                if character.status == "Alive" {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(Color.green)
                } else if character.status == "Dead" {
                    Image(systemName: "dot.scope")
                        .foregroundStyle(Color.red)
                } else {
                    Image(systemName: "person.crop.circle.badge.questionmark.fill")
                        .foregroundStyle(Color.orange)
                }
                
                Text(character.status)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text("status:\(character.status )"))
            
            HStack(spacing: 2) {
                Text(character.gender)
                Text(character.species)
                Text(character.type ?? "")
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text("\(character.gender) \(character.species)"))
            
            Text("From: \(character.origin.name)")
            Spacer()
            VStack {
                Text("Created:")
                Text(date ?? Date(), style: .date)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text("Created\(date ?? Date(), style: .date)"))
            
                
            .font(.headline)
            .fontWeight(.medium)
            .padding(.horizontal)
            .lineLimit(nil)
            .fixedSize()
            Spacer()
        }
        .onAppear {
            date = dateFromISOString(character.created)
        }
    }
}


func dateFromISOString(_ isoString: String) -> Date? {
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withFullDate]  // ignores time!
    return isoDateFormatter.date(from: isoString)  // returns nil, if isoString is malformed.
}

//#Preview {
//    DetailView()
//}
