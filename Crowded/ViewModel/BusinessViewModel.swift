//
//  BusinessViewModel.swift
//  Crowded
//
//  Created by Blain Ellis on 04/10/2021.
//

import Foundation

class BusinessViewModel {
    
    let cities: Dynamic<[City]> = Dynamic([])
    let selectedCity = Dynamic("")
    
    let businesses: Dynamic<[Business]> = Dynamic([])
    
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
    
    func fetchBusinesses(in city: City?) {
        
        let cityName = city == nil ? nil : city?.name
        NetworkController.shared.fetchBusinessess(in: cityName) { businesses in
            if let businesses = businesses {
                self.businesses.value = businesses
            }
            self.selectedCity.value = cityName ?? ""
        }
    }
}
