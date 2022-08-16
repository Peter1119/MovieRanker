//
//  MovieDetailPresenter.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/17.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {}

class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    init(viewController: MovieDetailProtocol) {
        self.viewController = viewController
    }
}
