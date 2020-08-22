//
//  ShoeViewController.swift
//  to-do_list
//
//  Created by User on 2020-07-28.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit

class ShoeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Outlets
    @IBOutlet weak var shoeTextField: UITextField!  //user input
    @IBOutlet weak var imageView: UIImageView!      //image view
    @IBOutlet weak var ratingControl: UIStackView!  //custom control
    
    //MARK: Actions
    //responds to user tap on image view
    @IBAction func imageTapGesture(_ sender: UITapGestureRecognizer){
        shoeTextField.resignFirstResponder()    //hide keyboard
        
        //class lets users pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //allows photos to be picked not taken
        imagePickerController.sourceType = .photoLibrary
        
        //notifies the view controller when user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shoeTextField.resignFirstResponder()    //hides the keyboard
        return true
    }
    
    //called when first responder resigns
    //handle user input here if needed
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //dismisses picker if image is cancelled
        dismiss(animated: true, completion: nil)
    }
    
    //called when user selects an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //grab the selected image from the info and cast it as UIImage
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as?
        UIImage else{
            fatalError("Expected dictionary containing an image but was given the following: \(info)")
        }
        
        //set the image view's image as the selected image
        imageView.image = pickedImage
        
        //dismiss picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign this view controller as delegate
        shoeTextField.delegate = self
    }
}

