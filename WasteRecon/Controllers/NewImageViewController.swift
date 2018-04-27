//
//  ViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 23/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class NewImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    //MARK: Properties
    var newImage: Image?
    let imageService = ImageServices()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var catName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        catName.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIIMagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imageView.image = selectedImage
        print("Image picked")
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: NSCharacterSet.letters.inverted) == nil
    }

    //MARK: UITapGestureRecognizer
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        catName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Save Button
    @IBAction func saveImage(_ sender: UIButton) {
        guard let catName = self.catName.text else{
            fatalError("catName prob")
        }
        guard let img = self.imageView.image else {
            fatalError("Image error")
        }
        let newImage = Image(catName: catName, img: img)
        print(newImage.name)
        print(newImage.catName)
        imageService.addImageToServer(newImage: newImage) {(complete) in
            print("success")
        }
        
    }
    
    
}

