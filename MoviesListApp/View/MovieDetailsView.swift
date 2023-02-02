//
//  MovieDetailsView.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 1/02/23.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @StateObject private var viewModel = CastViewModel()

    @State var cast: [MovieCastMember] = []

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
                Button("Retry?") {
                    Task {
                        await viewModel.loadCast(movie: movie)
                    }
                }
            case .loaded(let members):
                header()
                list(of: members)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(movie.title)
        .task {
            await viewModel.loadCast(movie: movie)
        }
    }

    func header() -> some View {
        HStack {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80)
            
            VStack {
                Text(movie.overview)
                    .font(.body)
            }
        }
        .padding()
    }

    @ViewBuilder
    func list(of members: [MovieCastMember]) -> some View {
        if members.isEmpty {
            Text("No members for this movie")
        } else {
            List {
                ForEach(members) { member in
                    VStack(alignment: .leading) {
                        Text(member.character)
                        Text(member.name)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: .mock, cast: .mock)
    }
}
