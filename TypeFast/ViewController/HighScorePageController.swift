//
//  HighScorePageController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import UIKit

class HighScorePageController: UIPageViewController{
    private(set) var orderOfControllers: [String]  = { getCorrectOrderOfControllers() }()
    private(set) lazy var orderedViewControllers: [HighScoreViewController] = {
        return [self.newHighScoreViewController(level: orderOfControllers[0]),
                self.newHighScoreViewController(level: orderOfControllers[1]),
                self.newHighScoreViewController(level: orderOfControllers[2]),
                self.newHighScoreViewController(level: orderOfControllers[3])]
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
        setFirstViewController()
    }
    
    private func setFirstViewController(){
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],direction: .forward,
                    animated: true,
                    completion: nil)
        }
    }
    
}
