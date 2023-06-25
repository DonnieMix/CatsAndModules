//
//  CatsListViewModel.swift
//  CatsAndModules
//
//  Created by Kyrylo Derkach on 30.05.2023.
//

import Foundation
import Networking

class AnimalsListViewModel : ObservableObject {
    @Published var animals: [Animal] = []
    
    func fetchCats(amount: Int) {
        AnimalsNetworking.getCats(amount: amount) { catsList, error in
            guard let catsList = catsList else {
                return
            }
            
            DispatchQueue.main.async {
                self.animals = catsList
            }
        }
    }
    
    func fetchDogs(amount: Int) {
        AnimalsNetworking.getDogs(amount: amount) { dogsList, error in
            guard let dogsList = dogsList else {
                return
            }
            
            DispatchQueue.main.async {
                self.animals = dogsList
            }
        }
    }
}
