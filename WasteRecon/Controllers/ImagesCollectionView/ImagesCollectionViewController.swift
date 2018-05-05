//
//  ImagesCollectionViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class ImagesCollectionViewController: UICollectionViewController {

    //MARK: Properties
    var images = [Image]()
    var selectedImage: Image?
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadImages()
        self.collectionView!.reloadData()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImagesCollectionViewCell else {
            fatalError("cell cannot be created")
        }
        let image = images[indexPath.row]

        cell.imageView.image = image.img
        cell.imageView.setImageAndShadow(image: cell.imageView.image!, myView: view, radius: 10)
        cell.selectedImage = image
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagesCollectionViewCell else {
            fatalError("ImagesCollectionVC: cant get cell")
        }
        
        self.selectedImage = cell.selectedImage
        self.performSegue(withIdentifier: "showImage", sender: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showImage"){
            guard let selectedImage = segue.destination as? SelectedImageViewController else {
                fatalError("ImagesCollection: cant create selectedImage")
            }
            
            selectedImage.selectedImage = self.selectedImage
        }
        
        //Customize back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Images", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .white

    }
    
    //MARK: Private function
    func loadImages(){
        images = ImageServices.globalImages.getAllImages()
    }
    

}
