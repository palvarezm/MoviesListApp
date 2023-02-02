//
//  CastService.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 1/02/23.
//

import Foundation

class CastService {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func getCast(of movie: Movie) async throws -> [MovieCastMember] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)")!

        let (data, _) = try await URLSession.shared.data(from: url)

        let decoded = try jsonDecoder.decode(MovieCreditsResponse.self, from: data)
        
        return decoded.cast
    }
}
