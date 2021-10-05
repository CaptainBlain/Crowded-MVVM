//
//  CitySelectViewModel.swift
//  Crowded
//
//  Created by Blain Ellis on 05/10/2021.
//

import Foundation

class CitySelectViewModel {
    
    let cities: Dynamic<[City]> = Dynamic([])
    
    init() {
        fetchAvailableCities()
    }
    
    func fetchAvailableCities() {
        
        NetworkController.shared.fetchAvailableCities { cities in
            if let cities = cities {
                self.cities.value = cities
            }
        }
    }

}
