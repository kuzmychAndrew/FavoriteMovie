//
//  ViewModel.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import Foundation

final class ViewModel{
    private var firebaseService: FirebaseServiceProtocol
    
    init(firebaseService: FirebaseServiceProtocol){
        self.firebaseService = firebaseService
    }
    
    func writeMovie(movie: MovieModel){
        firebaseService.saveMovie(movie: movie)
    }
    
    func readMovie(completion: @escaping([FirebaseModel])->()){
        var movies:[FirebaseModel] = []
        firebaseService.readMovie{ (newMovie) in
            movies =  newMovie
            }
        completion(movies)
    }
    
}
