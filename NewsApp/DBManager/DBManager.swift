//
//  DBManager.swift
//  NewsApp
//
//  Created by Aliia Saidillaeva  on 23/7/22.
//

import Foundation
import RealmSwift

class DBManager  {
    private var database: Realm
    static let shared = DBManager()
    
    private init() {
         database = try! Realm()
    }
    
    func getDataFromDB() ->  [DBArticle] {
      let results: Results<DBArticle> = database.objects(DBArticle.self)
        
        return Array(results)
     }
    
     func addData(object: DBArticle)   {
          try! database.write {
              database.add(object, update: .modified)
             print("Added new object")
          }
     }
    
    func deleteAllFromDatabase()  {
           try!   database.write {
               database.deleteAll()
           }
      }
}
