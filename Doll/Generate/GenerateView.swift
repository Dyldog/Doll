//
//  ContentView.swift
//  Doll
//
//  Created by Dylan Elliott on 5/8/2022.
//

import SwiftUI
import ActivityIndicatorView

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel = .init()
    @State var searchText: String = ""
    @State var lastSearch: String = ""
    
    @FocusState private var searchIsFocused: Bool
    
    var body: some View {
        ZStack {
            List {
                HStack {
                    TextField("Search", text: $searchText)
                        .focused($searchIsFocused)
                        .onSubmit {
                            viewModel.search(searchText)
                            searchIsFocused = false
                        }
                        .frame(maxHeight: .infinity)
                    Button("Search") {
                        viewModel.search(searchText)
                        lastSearch = searchText
                        searchIsFocused = false
                    }
                }
                
                if viewModel.isSearching == false {
                    ForEach(viewModel.images) { image in
                        ShareImage(title: lastSearch, image: image.image)
                    }
                }
                
            }
            .resignKeyboardOnDragGesture()
            
            ActivityIndicatorView(isVisible: $viewModel.isSearching, type: .growingArc(.accentColor, lineWidth: 4))
                .frame(width: 50.0, height: 50.0)
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
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
