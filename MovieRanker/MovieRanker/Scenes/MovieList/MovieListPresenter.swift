//
//  MovieListPresenter.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setUpNavigationBar()
    func setUpSearchBar()
    func setUpViews()
}

final class MovieListPresenter: NSObject {
    // 메모리 릭에 대한 예비
    private weak var viewController: MovieListViewController?
    
    init(viewController: MovieListViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setUpNavigationBar()
        viewController?.setUpSearchBar()
        viewController?.setUpViews()
    }
}

extension MovieListPresenter: UISearchBarDelegate { }

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210.0)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .red
        
        return cell
    }
}
