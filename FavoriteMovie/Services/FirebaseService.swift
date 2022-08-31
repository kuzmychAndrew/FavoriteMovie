//
//  FirebaseService.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import Foundation
import Firebase
protocol FirebaseServiceProtocol{
    func saveMovie(name: String, year: String)
    func readMovie(completion: @escaping([String])->())
}


final class FirebaseService: FirebaseServiceProtocol{
    private let ref = Database.database().reference(withPath: "movies")
    private var refObserver: [DatabaseHandle] = []
    var movies: [String] = []
    
    func saveMovie(name: String, year: String){
        var movie = "\(name + year)"
        let movieItem = FirebaseModel(movie: movie)
        
        let movieItemRef = self.ref.child(movie.lowercased())
        movieItemRef.setValue(movieItem.toAnyObject())
        print(movie)
    }
    func readMovie(completion: @escaping([String])->()){
        let completed = ref.observe(.value){ snapshot in
        var newMovie:[String] = []
        for child in snapshot.children {
            if
              let snapshot = child as? DataSnapshot,
              let movies = FirebaseModel(snapshot: snapshot) {
                newMovie.append(movies.movie)
            }
          }
            completion(newMovie)
        }
        self.refObserver.append(completed)
    }

}
