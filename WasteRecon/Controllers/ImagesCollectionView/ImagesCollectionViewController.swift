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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadImages()
        self.collectionView!.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        // Configure the cell
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
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showImage"){
            guard let selectedImage = segue.destination as? SelectedImageViewController else {
                fatalError("ImagesCollection: cant create selectedImage")
            }
            
            selectedImage.selectedImage = self.selectedImage
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Images", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .white

    }
    
    //MARK: Private function
    func loadImages(){
        images = ImageServices.globalImages.getAllImages()
        //print(images[0].name)
    }
    

}
