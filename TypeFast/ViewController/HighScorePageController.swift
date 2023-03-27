//
//  HighScorePageController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import UIKit

class HighScorePageController: UIPageViewController{
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(color: "Red"),
                self.newColoredViewController(color: "Red"),
                self.newColoredViewController(color: "Red")]
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
    
    deinit{
        printAny("deinit highscore page controller")
    }
    
}
