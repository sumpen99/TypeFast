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
            setViewControllers([firstViewController],direction: .forward,
                    animated: true,
                    completion: nil)
        }
    }
    
}
