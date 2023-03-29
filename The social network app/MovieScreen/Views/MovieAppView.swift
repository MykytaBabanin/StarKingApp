//
//  MovieDBViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 22.03.2023.
//

import SwiftUI

struct MovieAppView: View {
    @StateObject var viewModel = MovieListViewModel()
    @State var searchText = ""
    
    var body: some View {
        ScrollView {
            if searchText.isEmpty {
                if viewModel.trending.isEmpty {
                    ProgressView()
                } else {
                    CardHeader()
                }
                TrendingListView(viewModel: viewModel)
            } else {
                SearchListView(viewModel: viewModel)
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText, perform: { newValue in
            Task {
                if newValue.count > 2 {
                    await viewModel.search(term: searchText)
                }
            }
        })
        .onAppear {
            Task { await viewModel.loadTrending() }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden()
        .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())
    }
}

struct CardHeader: View {
    var body: some View {
        HStack() {
            Text("Trending")
                .font(.title)
                .foregroundColor(.white)
                .bold()
        }
        .padding(.trailing, 240)
    }
}

struct MovieDBViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MovieAppView()
    }
}
