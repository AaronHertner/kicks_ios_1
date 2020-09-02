//
//  ShoeTableViewController.swift
//  to-do_list
//
//  Created by User on 2020-08-22.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit
import os.log

class ShoeTableViewController: UITableViewController {
    
    //MARK: Properties
    var shoes = [Shoe]()
    
    //MARK: Actions
    @IBAction func unwindToShoeList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? ShoeViewController, let shoe = sourceViewController.shoe{
            
            //updates existing entry
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                shoes[selectedIndexPath.row] = shoe
                tableView.reloadData()
            }
                
            //adds new entry
            else{
                let indexPath = IndexPath(row: shoes.count, section: 0)
                shoes.append(shoe)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            saveShoes()
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        
        //pending segue is to add new shoe
        case "AddShoeItem":
            os_log("Adding a new item", log: OSLog.default, type: .debug)
        
        //pending segue is to edit shoe
        case "EditShoeDetails":
            
            //segue destination
            let shoeDetailViewController = segue.destination as? ShoeViewController
            
            //selected cell
            let selectedCell = sender as? ShoeTableViewCell
            
            //get cell position
            let indexPath = tableView.indexPath(for: selectedCell!)
            
            //get shoe data
            let selectedShoe = shoes[indexPath!.row]
            
            //assign the detail viewer shoe info
            shoeDetailViewController?.shoe = selectedShoe
        default:
            fatalError("Unexpected segue identifier; \(segue.identifier!)")
        }
    }
    
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
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedShoes = loadShoes() {
            shoes += savedShoes
        }else{
            loadSampleShoes()
        }
    }
    
    private func saveShoes(){
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: shoes, requiringSecureCoding: false)
            try data.write(to: Shoe.ArchiveURL)
        }catch{
            os_log("Could not save data", log: OSLog.default, type: .debug)
        }
    }
    
    private func loadShoes() -> [Shoe]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Shoe.ArchiveURL.path) as? [Shoe]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //editing style is delete
        if editingStyle == .delete {
            shoes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveShoes()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoes.count
    }
    
    //allows editing
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
