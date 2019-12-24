//
//  ViewController.swift
//  ProjectMushroom
//
//  Created by Maitree Bain on 11/26/19.
//  Copyright © 2019 Maitree Bain. All rights reserved.
//

import UIKit

class EdibleShroomViewController: UIViewController {

    @IBOutlet weak var edibleTableView: UITableView!
    
    @IBOutlet weak var edibleSearchBar: UISearchBar!
    
    
    var mushroom = [MushroomDataLoad]() {
        didSet {
            DispatchQueue.main.async {
                self.edibleTableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMushroomData()
        edibleTableView.dataSource = self
        edibleTableView.delegate = self
    }
    
    
    func loadMushroomData() {
        
        ShroomsAPIClient.fetchData { (result) in
            
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let mushroomData):
                self.mushroom = mushroomData
            }
        }
        
    }
    
    

}


extension  EdibleShroomViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mushroom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "edibleCell", for: indexPath) as? EdibleCell else {
            fatalError("check cell name")
        }
        
        let selectedShroom = mushroom[indexPath.row]
        
        //image nested in data
        //api client -> network
        
        if indexPath.row % 5 == 0{
            cell.backgroundColor = UIColor(displayP3Red: 48/255, green: 70/255, blue: 53/255, alpha: 0.9)
        } else if indexPath.row % 5 == 1 {
            cell.backgroundColor = UIColor(displayP3Red: 108/255, green: 144/255, blue: 109/255, alpha: 0.9)
        } else if indexPath.row % 5 == 2 {
            cell.backgroundColor = UIColor(displayP3Red: 72/255, green: 34/255, blue: 28/255, alpha: 0.9)
        } else if indexPath.row % 5 == 3 {
            cell.backgroundColor = UIColor(displayP3Red: 183/255, green: 157/255, blue: 62/255, alpha: 0.9)
        } else if indexPath.row % 5 == 4 {
            cell.backgroundColor = UIColor(displayP3Red: 144/255, green: 183/255, blue: 113/255, alpha: 0.9)
        }
        
        
        if selectedShroom.attributes.deadly == false && selectedShroom.attributes.poisonous == false && selectedShroom.attributes.psychoactive == false{
        
        cell.configureCell(for: selectedShroom, chosenMushroom: selectedShroom.latin)
        }
        // configure cell have your function accept the name of the current mushroom
        // use the 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
