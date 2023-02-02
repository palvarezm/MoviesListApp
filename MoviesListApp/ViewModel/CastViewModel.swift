//
//  CastViewModel.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 2/02/23.
//

import Foundation

@MainActor
class CastViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(cast: [MovieCastMember])
        case error(Error)
    }

    @Published var state: State = .loading

    let service = CastService()

    func loadCast(movie: Movie) async {
        do {
            let cast = try await service.getCast(of: movie)
            state = .loaded(cast: cast)
        } catch {
            state = .error(error)
        }
    }
}
