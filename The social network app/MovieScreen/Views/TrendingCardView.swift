//
//  TrendingCard.swift
//  The social network app
//
//  Created by Mykyta Babanin on 22.03.2023.
//

import SwiftUI

struct TrendingCardView: View {
    let trendingItem: Movie
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: trendingItem.backdropURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 200)
                } placeholder: {
                    Rectangle()
                        .fill(Color(red: 61/255, green: 61/255, blue: 88/255))
                        .frame(width: 300, height: 200)
                }
            }
            .padding(.vertical, -8)
            VStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("\(trendingItem.vote_average, specifier: "%.1f")")
                        .bold()
                    Spacer()
                }
                .foregroundColor(.yellow)
            }
            .padding()
            .background(Color(red: 61/255, green: 61/255, blue: 88/255))
        }
        .cornerRadius(10)
    }
}

struct Previews_TrendingCard_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCardView(trendingItem: Movie.init(adult: false,
                                              id: 10,
                                              poster_path: "",
                                              title: "Sdadsadsa",
                                              overview: "",
                                              vote_average: 10,
                                              backdrop_path: ""))
    }
}
