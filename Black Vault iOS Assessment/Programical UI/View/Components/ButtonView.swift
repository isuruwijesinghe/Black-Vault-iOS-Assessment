//
//  ButtonView.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 11/2/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    
    let btButton: UIButton = {
           let button = UIButton()
           button.setTitle("Sign Up", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
           button.setTitleColor(.gray, for: .normal)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.layer.cornerRadius = 10
           button.layer.borderWidth = 1
           button.layer.borderColor = UIColor.black.cgColor
           return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton(){
        
        NSLayoutConstraint.activate([
            btButton.topAnchor.constraint(equalTo: self.topAnchor),
            btButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            btButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            btButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}
