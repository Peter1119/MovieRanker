//
//  Movie.swift
//  MovieRanker
//
//  Created by Sh Hong on 2022/08/11.
//

import Foundation

struct Movie: Codable {
    let title: String?
    let link: String?
    let image: String?
    let subtitle, pubDate, director, actor: String?
    let userRating: String?
    var imageURL: URL? { return URL(string: image ?? "")}
}
