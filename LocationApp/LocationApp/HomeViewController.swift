//
//  ViewController.swift
//  LocationApp
//
//  Created by Amee Thakkar on 7/18/18.
//  Copyright © 2018 Amee Thakkar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var homeButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in homeButtons {
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 2.5
        }
    }


}

