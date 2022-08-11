//
//  ViewController.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieSearchManager().requestMovieList(from: "starwards") { movies in
            print(movies)
        }
    }

}
