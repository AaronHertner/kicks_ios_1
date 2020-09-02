//
//  ShoeViewController.swift
//  to-do_list
//
//  Created by User on 2020-07-28.
//  Copyright © 2020 aaronhertner. All rights reserved.
//

import UIKit
import os.log

class ShoeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Outlets
    @IBOutlet weak var shoeTextField: UITextField!  //user input
    @IBOutlet weak var imageView: UIImageView!      //image view
    @IBOutlet weak var ratingControl: CustomControl!  //rating
    @IBOutlet weak var saveButton: UIBarButtonItem! //save btn
    @IBOutlet weak var cancelButton: UIBarButtonItem!   //cancel btn
    
    
    /*
     This value is either passed by ShoeTableViewController
     via prepare(for:sender)
     or constructed as part of adding a new meal
     */
    var shoe : Shoe?
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //check that the save button was pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("Save button not pressed, cancelling", log: OSLog.default,type: .debug)
            return
        }
        
        let name = shoeTextField.text ?? ""
        let photo = imageView.image
        let rating = ratingControl.rating
        
        //prepare shoe for sending to table view
        shoe = Shoe.init(name: name, rating: rating, photo: photo)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let presentingFromAdd = presentingViewController is UINavigationController
        
        /*
         depending on how the page was presented
         modally or pushed
         the page needs to receed accordingly
         */
        
        //scene arrived from add button
        if presentingFromAdd {
            dismiss(animated: true, completion: nil)
        }
        
        //removes scene from navigation stack
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
        else{
            fatalError("ShoeViewController is not inside a navigation controller")
        }
    }
    
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    //called when first responder resigns
    //handle user input here if needed
    func textFieldDidEndEditing(_ textField: UITextField) {
        if shoeTextField.text != ""{
            saveButton.isEnabled = true
        }
        
        navigationItem.title = shoeTextField.text
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
        
        //populate ui with shoe property
        //if shoe property is non nil then views are updated
        if let shoe = shoe{
            navigationItem.title = shoe.name
            shoeTextField.text = shoe.name
            imageView.image = shoe.photo
            ratingControl.rating = shoe.rating
        }
    }
}

