//
//  CustomControl.swift
//  to-do_list
//
//  Created by User on 2020-08-12.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit

@IBDesignable class CustomControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonStates()
        }
    }
    
    //MARK: Inspectable
    //inspectable allows the properties to be edited from IB
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        
        //calls setup function when updated in IB
        didSet{
            setupButton()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButton()
        }
    }
    
    //MARK: Initialization
    
    //init for programmatically creating control
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    //init for storyboarding
    required init(coder: NSCoder){
        super.init(coder: coder)
        setupButton()
    }
    
    //MARK: Button Actions
    @objc func buttonTapped (button: UIButton){
        
        //finds index of selected button
        guard let index = ratingButtons.firstIndex(of: button) else{
            fatalError("idek mang")
        }
        
        //sets the rating value to index + 1
        let selectedRating = index + 1
        
        //sets internal rating value
        if selectedRating == rating {
            rating = 0
        }
        else{
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    private func setupButton(){
        
        //remove existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //add star images
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        //create buttons and add them to the interface
        for _ in 0..<starCount{
            //create button
            let button = UIButton()
            
            //add star images to buttons
            button.setImage(emptyStar, for: .normal)
            button.setImage(highStar, for: .selected)
            button.setImage(highStar, for: .highlighted)
            button.setImage(highStar, for: [.highlighted, .selected])
            
            //add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //add button action
            button.addTarget(self, action: #selector (CustomControl.buttonTapped(button:)), for: .touchUpInside)
            
            //add button to stack view
            addArrangedSubview(button)
            
            //add buttons to internal array
            ratingButtons.append(button)
            
            //reset button states
            updateButtonStates()
        }
    }
    
    //updates button states for visual clarity
    private func updateButtonStates(){
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
}
