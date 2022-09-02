//
//  FirebaseModel.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import Foundation
import Firebase

struct FirebaseModel: Hashable{
    let ref: DatabaseReference?
    let key: String
    let movie: String
    let year: String
    
    init(movie: String, year: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.movie = movie
        self.year = year
      }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let year = value["year"] as? String,
        let movie = value["movie"] as? String else {return nil}
      self.ref = snapshot.ref
      self.key = snapshot.key
      self.movie = movie
        self.year = year
    }

    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "movie": movie,
        "year": year
      ]
    }

}



