//
//  HighScorePageController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import UIKit

class HighScorePageController: UIPageViewController{
    
    private(set) lazy var orderedViewControllers: [HighScoreViewController] = {
        return [self.newHighScoreViewController(level: "Easy"),
                self.newHighScoreViewController(level: "Medium"),
                self.newHighScoreViewController(level: "Hard"),
                self.newHighScoreViewController(level: "Expert")]
    }()

    private func newHighScoreViewController(level: String) -> HighScoreViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "HighScoreViewController") as! HighScoreViewController
        viewController.level = level
        return viewController
        //return UIStoryboard(name: "Main", bundle: nil)
            //.instantiateViewController(withIdentifier: "\(color)ViewController") as! HighScoreViewController
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
