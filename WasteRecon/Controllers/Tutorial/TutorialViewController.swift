//
//  TutorialViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 06/05/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //MARK: Properties
    private(set) lazy var tutorialVC: [UIViewController] = {
        return [self.getViewController(name: "NewImgTutor"),
                self.getViewController(name: "CategoriesTutor"),
                self.getViewController(name: "ImagesTutor")]
    }()

    //MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        if let firstViewController = tutorialVC.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Datasource
    //Set page order forward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = tutorialVC.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard tutorialVC.count > previousIndex else {
            return nil
        }
        
        return tutorialVC[previousIndex]
    }
    //Set page order backward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = tutorialVC.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let tutorialVCCount = tutorialVC.count
        
        guard tutorialVCCount != nextIndex else {
            return nil
        }
        
        guard tutorialVCCount > nextIndex else {
            return nil
        }
        
        return tutorialVC[nextIndex]
    }
    
    //MARK: PageControl: show page indicator
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return tutorialVC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstViewControllerIndex = tutorialVC.index(of: firstVC) else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    //MARK: Private Method
    //Get viewController with name
    private func getViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"\(name)")
    }
}
