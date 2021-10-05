//
//  LocationHeader.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class LocationHeader: UICollectionReusableView {
    
    static let identifier = "LocationHeader"
    
    @IBOutlet weak var locationHeaderButton: UIButton!
    @IBAction func didPressLocationHeaderButton(_ sender: Any) { }
    
    @IBOutlet weak var locationHeaderSettingsButton: UIButton!
    @IBAction func didPressLocationHeaderSettingsButton(_ sender: Any) { }
    
    func setTitle(title: String) {
        locationHeaderButton.setTitleColor(UIColor(named: "textFieldText"), for: .normal)
        locationHeaderButton.setTitle(title, for: .normal)
    }
    
    func setPlaceholder(title: String) {
        locationHeaderButton.setTitleColor(UIColor(named: "textFieldPlaceholder"), for: .normal)
        locationHeaderButton.setTitle(title, for: .normal)
    }
}
