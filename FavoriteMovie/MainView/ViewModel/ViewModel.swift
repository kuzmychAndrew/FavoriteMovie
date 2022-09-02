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
    
    func writeMovie(movie: FirebaseModel, comletion: @escaping(Bool) ->()){
        var checkVM = false
        firebaseService.saveMovie(movie: movie,comletion: { (check) in
            checkVM = check
            print("\(checkVM) view model")
            comletion(checkVM)

        })
        
                
    }
    
    func readMovie(completion: @escaping([FirebaseModel])->()){
        var movies:[FirebaseModel] = []
        firebaseService.readMovie{ (newMovie) in
            movies =  newMovie
            }
        completion(movies)
    }
    
}
