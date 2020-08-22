//
//  ShoeTableViewController.swift
//  to-do_list
//
//  Created by User on 2020-08-22.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit

class ShoeTableViewController: UITableViewController {
    
    //MARK: Properties
    var shoes = [Shoe]()
    
    //MARK: Private Functions
    private func loadSampleShoes(){
        
        //load photos
        let photo_np = UIImage(named: "nike-pink")
        let photo_aj1 = UIImage(named: "nike-airjordan1s")
        let photo_cw = UIImage(named: "nike-cw")
        
        //create shoe objects
        guard let shoe_np = Shoe.init(name: "Nike Pink", rating: 5, photo: photo_np) else{
            fatalError("shoe_np failed to init")
        }
        guard let shoe_aj1 = Shoe.init(name: "Nike Air Jordan 1's", rating: 5, photo: photo_aj1) else{
            fatalError("shoe_aj1 failed to init")
        }
        guard let shoe_cw = Shoe.init(name: "Nike CW", rating: 5, photo: photo_cw) else{
            fatalError("shoe_cw failed to init")
        }
        
        shoes += [shoe_np, shoe_aj1, shoe_cw]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load sample shoe data
        loadSampleShoes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ShoeTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShoeTableViewCell else{
            fatalError("Dequeued cell is not an instance of ShoeTableViewCell")
        }
        
        let shoe = shoes[indexPath.row]
        
        cell.photo.image = shoe.photo
        cell.rating.rating = shoe.rating
        cell.title.text = shoe.name
        
        return cell
    }
}
