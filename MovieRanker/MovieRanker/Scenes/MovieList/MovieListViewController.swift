//
//  ViewController.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import UIKit
import SnapKit
import Then

final class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPresenter(viewController: self)
    
    private let searchController = UISearchController()
    
    private lazy var movieListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var searchTableView = UITableView().then {
        $0.delegate = presenter
        $0.dataSource = presenter
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension MovieListViewController: MovieListProtocol {
    func setUpNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setUpSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
    func setUpViews() {
        [movieListCollectionView, searchTableView]
            .forEach { view.addSubview($0) }
        
        movieListCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateSearchTableView(isHidden: Bool) {
        searchTableView.isHidden = isHidden
    }
}
