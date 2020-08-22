//
//  Shoe.swift
//  to-do_list
//
//  Created by User on 2020-08-21.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit

class Shoe
{
    //MARK: Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    //MARK: Initialization
    
    //failable constructor
    init?(name: String, rating: Int, photo: UIImage?){
        if (name.isEmpty || rating < 0) {return nil}
        
        self.name = name
        self.rating = rating
        self.photo = photo
    }
    
    
}
