//
//  MoviesViewModel.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 1/02/23.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(movies: [Movie])
        case error(Error)
    }

    @Published var state: State = .loading

    let service = MoviesService()

    func loadMovies() async {
        do {
            let movies = try await service.getMoviesFromAPI()
            state = .loaded(movies: movies)
        } catch {
            state = .error(error)
        }
    }
}
