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
    var image: String?
    let subtitle, pubDate, director, actor: String?
    let userRating: String?
    var imageURL: URL? { return URL(string: image ?? "")}
    var isLiked: Bool
    
    private enum CodingKeys: String, CodingKey {
        case title, link, image, subtitle, pubDate, director, actor
        case userRating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? "-"
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? "-"
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) ?? "-"
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? "-"
        director = try container.decodeIfPresent(String.self, forKey: .director) ?? "-"
        actor = try container.decodeIfPresent(String.self, forKey: .actor) ?? "-"
        userRating = try container.decodeIfPresent(String.self, forKey: .userRating) ?? "-"
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        
        isLiked = false
    }
}
