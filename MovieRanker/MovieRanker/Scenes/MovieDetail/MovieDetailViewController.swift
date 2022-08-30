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
        
        navigationItem.title = movie.title?
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
        imageView.kf.setImage(with: movie.imageURL)
        
        let ratingContentsStack = MovieContentsStackView(title: "평점", contents: movie.userRating ?? String())
        let actorContentsStack = MovieContentsStackView(title: "배우", contents: movie.actor ?? String())
        let directorContentStack = MovieContentsStackView(title: "감독", contents: movie.director ?? String())
        let pubDateContentStack = MovieContentsStackView(title: "제작년도", contents: movie.pubDate ?? String())
        
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 8
        
        [
            ratingContentsStack,
            actorContentsStack,
            directorContentStack,
            pubDateContentStack
        ].forEach { contentStack.addArrangedSubview($0)}
        
        let margin: CGFloat = 16
                
        [imageView, titleLabel, contentStack]
            .forEach { self.view.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(margin)
            make.left.right.equalToSuperview().inset(margin)
            make.height.equalTo(imageView.snp.width)
        }

        contentStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(margin)
            make.left.right.equalTo(imageView)
        }
    }
}
