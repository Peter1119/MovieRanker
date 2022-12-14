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
    func pushToMovieDetailViewController(with movie: Movie)
}

final class MovieListPresenter: NSObject {
    // 메모리 릭에 대한 예비
    private weak var viewController: MovieListViewController?
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let movieSearchManager: MovieSearchManagerProtocol
    
    private var searchedMovie = [Movie]()
    private var likedMovie = [Movie]()
    
    init(
        viewController: MovieListViewController,
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setUpNavigationBar()
        viewController?.setUpSearchBar()
        viewController?.setUpViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefaultsManager.getMovies()
        viewController?.updateCollectionView()
    }
}

extension MovieListPresenter: UISearchBarDelegate { }

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.item]
        viewController?.pushToMovieDetailViewController(with: movie)
    }
    
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
        return likedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = likedMovie[indexPath.item]
        cell.bind(movie)
        
        return cell
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = searchedMovie[indexPath.row]
        viewController?.pushToMovieDetailViewController(with: movie)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedMovie = []
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.requestMovieList(from: searchText) { [weak self] movies in
            self?.searchedMovie = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchedMovie[indexPath.row].title?
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "") ?? ""
        return cell
    }
}
