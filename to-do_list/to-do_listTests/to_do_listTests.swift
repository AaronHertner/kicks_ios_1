//
//  to_do_listTests.swift
//  to-do_listTests
//
//  Created by User on 2020-08-22.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import XCTest
@testable import to_do_list

class to_do_listTests: XCTestCase {
    
    //MARK: Shoe Class Tests
    func testShoeInitSuccess() {
        let fiveRatingShoe : Shoe? = Shoe.init(name: "Nike Air270's", rating: 5, photo: nil)
        XCTAssertNotNil(fiveRatingShoe)
        
        let zeroRatingShoe : Shoe? = Shoe.init(name: "Under Armour Hovr's", rating: 0, photo: nil)
        XCTAssertNotNil(zeroRatingShoe)
    }
    
    func testShoeInitFail(){
        let negativeRatingShoe : Shoe? = Shoe.init(name: "Crocs", rating: -1, photo: nil)
        XCTAssertNil(negativeRatingShoe)
    }
}
