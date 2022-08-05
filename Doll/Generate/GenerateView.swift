//
//  ContentView.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel = .init()
    @State var searchText: String = ""
    @State var lastSearch: String = ""
    
    var body: some View {
        List {
            HStack {
                TextField("Search", text: $searchText)
                Button("Search") {
                    viewModel.search(searchText)
                    lastSearch = searchText
                }
            }
            
            if viewModel.isSearching {
                ProgressView()
            } else {
                ForEach(viewModel.images) { image in
                    ShareImage(title: lastSearch, image: image.image)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ShareImage: View {
    let title: String
    let image: UIImage
    var body: some View {
        Button(action: {
            if let url = image.saveToTemporaryFile(named: "\(title)-\(String.dateTime)") {
                share(items: [url])
            }
        }) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
