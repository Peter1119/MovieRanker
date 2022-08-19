//
//  MovieDetailViewController.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/17.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController, MovieDetailProtocol {
    private var presenter: MovieDetailPresenter!
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    init(movie: Movie) {
         super.init(nibName: nil, bundle: nil)
        
        presenter = MovieDetailPresenter(viewController: self, movie: movie)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension MovieDetailViewController {
    func setViews(with movie: Movie) {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title
        
        layout()
    }
    
    // MARK: - Layout
    private func layout() {
        [imageView]
            .forEach { self.view.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(imageView.snp.width)
        }
    }
}
