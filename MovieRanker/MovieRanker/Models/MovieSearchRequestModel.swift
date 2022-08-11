//
//  MovieSearchRequestModel.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import Foundation
import Alamofire

struct MovieSearchRequestModel: Encodable {
    let keyword: String
    func toParameters() -> Parameters {
        return ["query": keyword]
    }
}
