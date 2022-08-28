//
//  MovieDetailViewController.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/17.
//

import UIKit
import Kingfisher
import SnapKit

final class MovieDetailViewController: UIViewController, MovieDetailProtocol {
    private var presenter: MovieDetailPresenter!
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
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
        imageView.kf.setImage(with: movie.imageURL)
        
        let ratingContentsStack = MovieContentsStackView(title: "평점", contents: movie.userRating)
        let actorContentsStack = MovieContentsStackView(title: "배우", contents: movie.actor)
        
        let margin: CGFloat = 16
                
        [imageView, titleLabel]
            .forEach { self.view.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(margin)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(imageView.snp.width)
        }

    }
}
