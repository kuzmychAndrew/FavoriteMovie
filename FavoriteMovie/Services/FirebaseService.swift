//
//  FirebaseService.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import Foundation
import Firebase
protocol FirebaseServiceProtocol{
    func saveMovie(movie: FirebaseModel, comletion: @escaping(Bool) -> ())
    func readMovie(completion: @escaping([FirebaseModel])->())
}


final class FirebaseService: FirebaseServiceProtocol{
    private let ref = Database.database().reference(withPath: "movies")
    private var refObserver: [DatabaseHandle] = []
    var movies:Set <String> = []
    
    func saveMovie(movie: FirebaseModel, comletion: @escaping(Bool) -> ()){
        var check = false
        var movieID = "\(movie.movie + movie.year)"
        let movieItem = FirebaseModel(movie: movie.movie, year: movie.year, key: movieID)
        let moviewBD = Database.database().reference().child("movies")
        
        moviewBD.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(movieID.lowercased()){
                check = true
                
                print("\(check) services")
                print("error")
                comletion(check)
            }else{
                check = false
                let movieItemRef = self.ref.child(movieID.lowercased())
                movieItemRef.setValue(movieItem.toAnyObject())
                print("success")
                comletion(check)
                
            }
        })
        print(check)
    }
    func readMovie(completion: @escaping([FirebaseModel])->()){
        let completed = ref.observe(.value){ snapshot in
        var newMovie:[FirebaseModel] = []
        for child in snapshot.children {
            if
              let snapshot = child as? DataSnapshot,
              let movies = FirebaseModel(snapshot: snapshot) {
                newMovie.append(movies)
            }
          }
            completion(newMovie)
        }
        self.refObserver.append(completed)
    }

}
