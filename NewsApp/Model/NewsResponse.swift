//
//  NewsResponse.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 21/7/22.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String?
    let articles: [Articles]?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case articles = "articles"
        case totalResults = "totalResults"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(String.self, forKey: .status)
        articles = try? values.decodeIfPresent([Articles].self, forKey: .articles)
        totalResults = try? values.decodeIfPresent(Int.self, forKey: .totalResults)
    }

}
