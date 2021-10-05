//
//  CitySelectViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 04/10/2021.
//

import UIKit

class CitySelectViewController: UIViewController {
    
    var delegate: CitySelectDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = CitySelectViewModel()
    private var cities = [City]()
   
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup the viewModel
        bind(to: viewModel)
    }
    
    func bind(to businessViewModel: CitySelectViewModel) {
        businessViewModel.cities.bind { [weak self] cities in
            self?.cities = cities
            self?.reloadData()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
        
}

extension CitySelectViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CitySelectTableViewCell.identifier, for: indexPath) as! CitySelectTableViewCell
        cell.citySelectTitleLabel.text = cities[indexPath.row].name
        return cell
    }
}

extension CitySelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        delegate?.citySelectViewController(self, didSelect: cities[indexPath.row])
    }
}
