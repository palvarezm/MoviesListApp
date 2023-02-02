//
//  MovieView.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 1/02/23.
//

import SwiftUI

struct MovieView: View {
    enum Constants {
        static let imageWidth = CGFloat(80)
        static let overviewLineLimit = 4
    }

    @StateObject private var viewModel = MoviesViewModel()

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
                Button("Retry?") {
                    Task {
                        await viewModel.loadMovies()
                    }
                }
            case .loaded(let movies):
                list(of: movies)
            }
        }
        .navigationTitle("Upcoming Movies")
        .task {
            await viewModel.loadMovies()
        }
    }

    @ViewBuilder  
    private func list(of movies: [Movie]) -> some View {
        if movies.isEmpty {
            Text("No upcoming movies")
        } else {
            List(movies) { movie in
                NavigationLink{
                    MovieDetailsView(movie: movie)
                } label: {
                    HStack {
                        AsyncImage(url: movie.posterURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: Constants.imageWidth)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                                .frame(alignment: .leading)
                            Text(movie.overview)
                                .font(.caption)
                                .lineLimit(Constants.overviewLineLimit)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieView()
        }
    }
}
