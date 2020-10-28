//
//  PageCell.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/28/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    //image View
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bearImage"))
        // you must enable this to put autolayouts
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        // you must enable this to put autolayouts
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Hi this is an autoLayout app !", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for the auto layout contraints and have loards of fun and etc with lorum ipsum xD see you soon", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .purple
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
            
            //toplayout
            let topImagecontainerView = UIView()
    //        topImagecontainerView.backgroundColor = .blue
            addSubview(topImagecontainerView)
            //enable this
            topImagecontainerView.translatesAutoresizingMaskIntoConstraints = false
            topImagecontainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            topImagecontainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            topImagecontainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            topImagecontainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
            
            //bear Image
            topImagecontainerView.addSubview(bearImageView)
            bearImageView.centerXAnchor.constraint(equalTo: topImagecontainerView.centerXAnchor).isActive = true
            bearImageView.centerYAnchor.constraint(equalTo: topImagecontainerView.centerYAnchor).isActive = true
            bearImageView.heightAnchor.constraint(equalTo: topImagecontainerView.heightAnchor, multiplier: 0.5).isActive = true

            
            // title text
            addSubview(titleTextView)
            titleTextView.topAnchor.constraint(equalTo: topImagecontainerView.bottomAnchor).isActive = true
            titleTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
            titleTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
            titleTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            
            
        }
}
