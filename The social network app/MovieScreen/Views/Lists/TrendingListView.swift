//
//  TrendingList.swift
//  The social network app
//
//  Created by Mykyta Babanin on 23.03.2023.
//

import SwiftUI

struct TrendingListView: View {
    @StateObject var viewModel: MovieListViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.trending) { trendingItem in
                    TrendingCardView(trendingItem: trendingItem)
                }
            }
            .padding(.horizontal)
        }
    }
}
