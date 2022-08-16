//
//  MovieDetailViewController.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/17.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController, MovieDetailProtocol {
    private lazy var presenter = MovieDetailPresenter(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}
