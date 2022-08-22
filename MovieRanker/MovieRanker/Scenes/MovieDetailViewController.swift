//
//  MovieDetailViewController.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/17.
//

import UIKit
import Kingfisher
import PinLayout

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
    
    private lazy var rankingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "평점"
        return label
    }()
    
    private lazy var rankingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "배우"
        return label
    }()
    
    private lazy var actorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "감독"
        return label
    }()
    
    private lazy var directorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var movieMakingYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "제작년도"
        return label
    }()
    
    private lazy var movieMakingYearDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
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
        
        layout()
    }
    
    // MARK: - Layout
    private func layout() {
        [imageView]
            .forEach { self.view.addSubview($0) }
        imageView.sizeToFit()
        imageView.pin.top(self.view.pin.safeArea).left().right().marginTop(16).marginHorizontal(16)
            .height(imageView.frame.width)
    }
}
