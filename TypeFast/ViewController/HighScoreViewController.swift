//
//  HighScoreViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//

import UIKit

class HighScoreViewController: UIPageViewController{
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(color: "Green"),
                self.newColoredViewController(color: "Red"),
                self.newColoredViewController(color: "Blue")]
    }()

    private func newColoredViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "\(color)ViewController")
        /*return storyboard?
        .instantiateViewController(withIdentifier: "\(color)ViewController") as? UIViewController ?? UIViewController()*/
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController],
                                   direction: .forward,
                    animated: true,
                    completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.firstIndex(where: {$0 === viewController}) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
                return orderedViewControllers.last
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
    }

    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(where: {$0 === viewController}) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
                return orderedViewControllers.first
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
    }
}
