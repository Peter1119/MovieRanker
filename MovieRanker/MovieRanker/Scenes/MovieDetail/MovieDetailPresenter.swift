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
}

class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    private var movie: Movie
    
    init(
        viewController: MovieDetailProtocol,
        movie: Movie
    ) {
        self.viewController = viewController
        self.movie = movie
    }
    
    func viewDidLoad() {
        viewController?.setViews(with: movie)
    }
}
