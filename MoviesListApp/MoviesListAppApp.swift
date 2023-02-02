//
//  MoviesListAppApp.swift
//  MoviesListApp
//
//  Created by Paul Alvarez on 1/02/23.
//

import SwiftUI

@main
struct MoviesListAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MovieView()
            }
        }
    }
}
