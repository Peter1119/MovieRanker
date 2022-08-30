//
//  MovieListCollectionViewCell.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var userRantingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ movie: Movie) {
        setUpView()
        setUpLayout()
        
        imageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title?.replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "") ?? ""
        userRantingLabel.text = "⭐️ \(movie.userRating ?? "")"
    }
}

private extension MovieListCollectionViewCell {
    func setUpView() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8.0
        
        backgroundColor = .systemBackground
    }
    
    func setUpLayout() {
        [imageView, titleLabel, userRantingLabel]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16.0)
            make.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalTo(imageView)
        }
        
        userRantingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
}
