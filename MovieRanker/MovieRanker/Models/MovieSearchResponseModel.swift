//
//  MovieSearchResponseModel.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import Foundation

struct MovieSearchResponseModel: Decodable {
    let items: [Movie]
}
