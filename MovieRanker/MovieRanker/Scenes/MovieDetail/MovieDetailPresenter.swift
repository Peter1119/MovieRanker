//
//  MovieDetailPresenter.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/17.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {
    func viewDidLoad()
    func setViews(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
}

class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var movie: Movie
    
    init(
        viewController: MovieDetailProtocol,
        movie: Movie,
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movie = movie
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setViews(with: movie)
        viewController?.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonItem() {
        if movie.isLiked {
            userDefaultsManager.removeMovie(movie)
        } else {
            userDefaultsManager.addMovie(movie)
        }
        movie.isLiked.toggle()
        viewController?.setRightBarButton(with: movie.isLiked)
    }
}
