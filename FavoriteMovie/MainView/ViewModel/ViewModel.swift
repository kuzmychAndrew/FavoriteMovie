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
    
    func writeMovie(name: String, year:String){
        firebaseService.saveMovie(name: name, year: year)
    }
    
    func readMovie(completion: @escaping([String])->()){
        var movies:[String] = []
        firebaseService.readMovie{ (newMovie) in
            movies =  newMovie
            }
        completion(movies)
    }
    
}
