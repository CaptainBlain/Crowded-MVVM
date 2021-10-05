//
//  CitySelectDelegate.swift
//  Crowded
//
//  Created by Blain Ellis on 04/10/2021.
//

import Foundation

protocol CitySelectDelegate {
    func citySelectViewController(_ citySelectViewController: CitySelectViewController, didSelect city: City)
}
