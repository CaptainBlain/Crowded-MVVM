//
//  BusinessViewModel.swift
//  Crowded
//
//  Created by Blain Ellis on 04/10/2021.
//

import Foundation

class BusinessViewModel {
    
    //Setup data-binding
    let selectedCity = Dynamic("")
    let businesses: Dynamic<[Business]> = Dynamic([])
    
    init() {
        //Immediately fetch the businesses to make them available to the user
        fetchBusinesses(in: nil)
    }
    
    func fetchBusinesses(in city: City?) {
        //Determine the city the user has requested, if any
        let cityName = city == nil ? nil : city?.name
        //Ask the network controller to fetch the businesses
        NetworkController.shared.fetchBusinessess(in: cityName) { businesses in
            if let businesses = businesses {
                self.businesses.value = businesses
            }
            self.selectedCity.value = cityName ?? ""
        }
    }
}

