//
//  Articles.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 13/7/22.
//

import Foundation
import RealmSwift
import Realm

protocol IArticle {
    associatedtype SourceType
    var source: SourceType? { get set }
    var author: String? { get set }
    var content: String? { get set }
    var urlToImage: String? { get set }
    var title: String? { get set }
    var publishedAt: String? { get set }
    var articleDescription: String? { get set }
    var url: String? { get set }
}

class Articles:  Decodable, IArticle {
    typealias SourceType = Source
    
    var source: Source? = nil
    var author: String? = ""
    var urlToImage: String? = ""
    var content: String? = ""
    var title: String? = ""
    var publishedAt: String? = ""
    var articleDescription: String? = ""
    var url: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case urlToImage
        case content
        case title
        case publishedAt
        case description
        case url
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try? values.decodeIfPresent(Source.self, forKey: .source)
        author = try? values.decodeIfPresent(String.self, forKey: .author)
        urlToImage = try? values.decodeIfPresent(String.self, forKey: .urlToImage)
        content = try? values.decodeIfPresent(String.self, forKey: .content)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        publishedAt = try? values.decodeIfPresent(String.self, forKey: .publishedAt)
        articleDescription = try? values.decodeIfPresent(String.self, forKey: .description)
        url = try? values.decodeIfPresent(String.self, forKey: .url)
    }
}

@objcMembers class DBArticle:  Object, IArticle {
    typealias SourceType = DBSource
    
    @Persisted(primaryKey: true) var title: String? = ""
    @Persisted var source: DBSource? = nil
    @Persisted var author: String? = ""
    @Persisted var content: String? = ""
    @Persisted var publishedAt: String? = ""
    @Persisted var articleDescription: String? = ""
    @Persisted var url: String? = ""
    @Persisted var urlToImage: String? = ""

    
    override init() {
        super.init()
    }
    
    init(_ article: Articles) {
        self.source = DBSource(source: article.source!)
        self.author = article.author
        self.content = article.content
        self.title = article.title
        self.publishedAt = article.publishedAt
        self.articleDescription = article.articleDescription
        self.url = article.url
        self.urlToImage = article.urlToImage
    }
    
}
