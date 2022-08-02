//
//  Source.swift
//  NewsApp
//
//  Created by Aliia Saidillaeva  on 1/8/22.
//

import Foundation
import Realm
import RealmSwift

protocol ISource {
    var id: String? { get set }
    var name: String? { get set }
}


class Source: Codable, ISource {
   var id: String? = ""
   var name: String? = ""

   enum CodingKeys: String, CodingKey {
       case id
       case name
   }

   required init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       id = try? values.decodeIfPresent(String.self, forKey: .id)
       name = try? values.decodeIfPresent(String.self, forKey: .name)
   }
    
}


@objcMembers class DBSource: Object, ISource {
    @Persisted(primaryKey: true) var id: String? = ""
    @Persisted var name: String? = ""
   
    override init() {
        super.init()
    }
    init(source: Source) {
        self.id = source.id
        self.name = source.name
    }

}


