//
//  MovieSearchManager.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import Foundation
import Alamofire

protocol MovieSearchManagerProtocol {
    func requestMovieList(from keyword: String, completion: @escaping([Movie]) -> Void)
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func requestMovieList(from keyword: String, completion: @escaping([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        let parameters = MovieSearchRequestModel(keyword: keyword).toParameters()
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "q4J0F0LcV_1JEXxI5N3z",
            "X-Naver-Client-Secret": "MfuLbuKkXd"
        ]
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers)
        .responseDecodable(of: MovieSearchResponseModel.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.items)
            case .failure(let error):
                print(error)
            }
        }
        .resume()
    }
}
