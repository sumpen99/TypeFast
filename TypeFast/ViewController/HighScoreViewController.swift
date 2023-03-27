//
//  HighScoreViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//

import UIKit

class HighScoreViewController: UIViewController{
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(close) , for: .touchUpInside)
    }
    
    @objc
    func close(){
        self.dismiss(animated: true)
    }
    
}
