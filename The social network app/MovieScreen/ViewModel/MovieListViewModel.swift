//
//  MovieDBViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 22.03.2023.
//

import SwiftUI

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    
    func loadTrending() async {
        do {
            if let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Credentials.apiKey)") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func search(term: String) async {
        do {
            if let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(Credentials.apiKey)&&include_adult=false&query=\(term)") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = trendingResults.results
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Movie: Decodable, Identifiable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?
    
    var backdropURL: URL? {
        if let baseURL = URL(string: "https://image.tmdb.org/t/p/w500"), let backdropPath = backdrop_path {
            return baseURL.appending(path: backdropPath)
        }
        return nil
    }
    
    var postThumbnail: URL {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")!
        return baseURL.appending(path: poster_path ?? "")
    }
}

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
