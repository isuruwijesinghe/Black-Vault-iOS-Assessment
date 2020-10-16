//
//  ViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/16/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var CurrentDateLabel: UILabel!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        LoginButton.layer.cornerRadius = 10
        LoginButton.layer.borderWidth = 1
        LoginButton.layer.borderColor = UIColor.black.cgColor
    }


}

