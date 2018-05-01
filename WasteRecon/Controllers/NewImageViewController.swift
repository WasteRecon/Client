//
//  ViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 23/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class NewImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    var newImage: Image?
    let imageService = ImageServices()
    let itemService = ItemServices()
    var newItem: Item?
    let materials: [String] = ["plastic", "glass", "paper", "fabric", "other"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shape: UITextField!
    @IBOutlet weak var matPickerView: UIPickerView!
    @IBOutlet weak var matLabel: UILabel!
    
    //MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        shape.delegate = self
        matPickerView.delegate = self
        matPickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UIIMagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("NewImageVC: Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imageView.image = selectedImage
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
        shape.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Save Button
    @IBAction func saveImage(_ sender: UIButton) {
        guard let shape = self.shape.text else{
            fatalError("NewImageVC: shape error")
        }
        guard let img = self.imageView.image else {
            fatalError("NewImageVC: Image error")
        }
        let newItem = Item(shape: shape, material: matLabel.text!)
        
        //GetCatName
        //Post img to server and performSegue
        itemService.getCatNameByItem(newItem: newItem) {(complete) in
            print("NewImageVC: getCatName success")
            self.newImage = Image(catName: self.itemService.catName!, img: img)
            self.imageService.addImageToServer(newImage: self.newImage!) {(complete) in
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDetail", sender: nil)
                }
            }
        }
    }
    
    //MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return materials[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        matLabel.text = materials[row]
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let categoryPageVC =  segue.destination as? CategoryPageViewController else{
            print("NewImageVC: cant create categoryPageVC")
            return
        }
        categoryPageVC.catName = itemService.catName
    }
    
}

