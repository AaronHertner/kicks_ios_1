//
//  Shoe.swift
//  to-do_list
//
//  Created by User on 2020-08-21.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit
import os.log

class Shoe : NSObject, NSCoding
{
    //MARK: Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("shoes")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialization
    
    //failable constructor
    init?(name: String, rating: Int, photo: UIImage?){
        if (name.isEmpty || rating < 0) {return nil}
        
        self.name = name
        self.rating = rating
        self.photo = photo
    }
    
    //MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder: NSCoder) {
        
        //name is required
        //if it cannot be decoded init should fail
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode Shoe Object", log: OSLog.default, type: .debug)
            return nil
        }
        
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, rating: rating, photo: photo)
    }
}
