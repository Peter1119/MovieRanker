//
//  UserDefaultsManager.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/31.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getMovies() -> [Movie]
    func addMovie(_ newMovie: Movie)
    func removeMovie(_ movie: Movie)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case movie
    }
    func getMovies() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: Key.movie.rawValue) else { return [] }
        
        return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
    }
    
    func addMovie(_ newMovie: Movie) {
        var currentMovies = getMovies()
        currentMovies.insert(newMovie, at: 0)
        
        // 새로 저장
        saveMovie(currentMovies)
    }
    
    func removeMovie(_ movie: Movie) {
        let currentMovies = getMovies()
        let newValue = currentMovies.filter { $0.title != movie.title }
        
        // 새로 저장
        saveMovie(newValue)
    }
    
    private func saveMovie(_ newValue: [Movie]) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(newValue),
            forKey: Key.movie.rawValue
        )
    }
}

