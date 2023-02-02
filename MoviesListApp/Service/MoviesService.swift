//
//  MoviesService.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 1/02/23.
//

import Foundation

class MoviesService {
    func getMoviesFromAPI() async throws -> [Movie] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
        let (data,_) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try decoder.decode(MovieResponse.self, from: data)
        
        return decodedData.results
    }
}
