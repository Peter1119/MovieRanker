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
    func updateSearchTableView(isHidden: Bool)
}

final class MovieListPresenter: NSObject {
    // 메모리 릭에 대한 예비
    private weak var viewController: MovieListViewController?
    
    private var searchedMovie = [Movie]()
    
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = searchedMovie[indexPath.item]
        cell.bind(movie)
        
        return cell
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: true)
    }
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
