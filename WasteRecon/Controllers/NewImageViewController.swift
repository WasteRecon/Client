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
    let itemService = ItemServices()
    var newItem: Item?
    var mat: String?
    let materials: [String] = ["Plastic", "Glass", "Paper", "Fabric", "Other"]
    
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var saveButton: CustomButton!
    @IBOutlet weak var shape: UITextField!
    @IBOutlet weak var matPickerView: UIPickerView!
    
    //MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        shape.delegate = self
        matPickerView.delegate = self
        matPickerView.dataSource = self
        
        saveButton.round(button: saveButton)
        matPickerView.selectRow(2, inComponent: 0, animated: false)
        mat = materials[2]
        imageView.setImageAndShadow(image: imageView.image!, myView: view, radius: 13)
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
        imageView.setImageAndShadow(image: imageView.image!, myView: view, radius: 13)
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
        guard let shape = self.shape.text?.lowercased() else{
            fatalError("NewImageVC: shape error")
        }
        guard let img = self.imageView.image else {
            fatalError("NewImageVC: Image error")
        }
        let newItem = Item(shape: shape, material: mat!.lowercased())
        
        //GetCatName
        //Post img to server and performSegue
        itemService.getCatNameByItem(newItem: newItem) {(complete) in
            print("NewImageVC: getCatName success")
            self.newImage = Image(catName: self.itemService.catName!, img: img)
            ImageServices.globalImages.addImageToServer(newImage: self.newImage!){(complete) in
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
        mat = materials[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        myLabel.text = materials[row]
        myLabel.textColor = UIColor.white
        myLabel.textAlignment = .center
        myLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        view.addSubview(myLabel)
        
        return view
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetail"){
            guard let categoryPageVC =  segue.destination as? CategoryPageViewController else{
                print("NewImageVC: cant create categoryPageVC")
                return
            }
            categoryPageVC.catName = itemService.catName
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "New Image", style: .plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem?.tintColor = .white
        }
    }
    
}

