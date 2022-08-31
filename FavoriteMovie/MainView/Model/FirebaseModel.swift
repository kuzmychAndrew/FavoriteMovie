//
//  FirebaseModel.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import Foundation
import Firebase

struct FirebaseModel{
    let ref: DatabaseReference?
    let key: String
    let movie: String
    
    init(movie: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.movie = movie
      }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let movie = value["movie"] as? String else {return nil}
      self.ref = snapshot.ref
      self.key = snapshot.key
      self.movie = movie
    }

    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "movie": movie
      ]
    }

}
