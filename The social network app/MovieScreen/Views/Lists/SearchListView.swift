//
//  TrendCard.swift
//  The social network app
//
//  Created by Mykyta Babanin on 23.03.2023.
//

import SwiftUI

struct SearchListView: View {
    @StateObject var viewModel: MovieListViewModel
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.searchResults) { item in
                if let backdropURL = item.backdropURL {
                    VStack {
                        HStack {
                            AsyncImage(url: backdropURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 120)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 80, height: 120)
                            }
                            .cornerRadius(10)
                            .clipped()
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                HStack {
                                    Image(systemName: "hand.thumbsup.fill")
                                    Text(String(format: "%.1f", item.vote_average))
                                    Spacer()
                                }
                                .foregroundColor(.yellow)
                                .fontWeight(.heavy)
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(red: 61/255, green: 61/255, blue: 88/255))
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
            }
        }
    }
}
