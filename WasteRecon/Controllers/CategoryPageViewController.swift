//
//  CategoryPageViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 30/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class CategoryPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //MARK: Properties
    private(set) lazy var categoryVC: [UIViewController] = {
        return [self.getViewController(name: "FirstPageViewController"),
                self.getViewController(name: "SecondPageViewController"),
                self.getViewController(name: "ThirdPageViewController")]
    }()
    
    //MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        // Do any additional setup after loading the view.
        
        if let firstViewController = categoryVC.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = categoryVC.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard categoryVC.count > previousIndex else {
            return nil
        }
        
        return categoryVC[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = categoryVC.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let categoryVCCount = categoryVC.count
        
        guard categoryVCCount != nextIndex else {
            return nil
        }
        
        guard categoryVCCount > nextIndex else {
            return nil
        }
        
        return categoryVC[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return categoryVC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstViewControllerIndex = categoryVC.index(of: firstVC) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    //MARK: Private Methods
    private func getViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"\(name)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
