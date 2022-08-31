//
//  ViewBuilder.swift
//  FavoriteMovie
//
//  Created by Андрій Кузьмич on 31.08.2022.
//

import Foundation

final class ViewBuilder{
    static func createModule() -> ViewModel{
        let firebaseService = FirebaseService()
        let viewModel = ViewModel(firebaseService: firebaseService)
        
        return viewModel
    }
}
