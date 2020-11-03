//
//  AutoLayoutViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/28/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class AutoLayoutViewController: UIViewController {
    
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
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV.", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    
    private let pageControle: UIPageControl = {
        let page = UIPageControl()
        page.currentPage = 0
        page.numberOfPages = 4
        page.currentPageIndicatorTintColor = .mainPink
        page.pageIndicatorTintColor = .lowPink
        return page
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set bear image view
//        view.addSubview(bearImageView)
        view.addSubview(titleTextView)
        
        setLayout()
        setButtonControlls()
        
        
    }
    
    fileprivate func setButtonControlls(){

        let bottomStackView = UIStackView(arrangedSubviews: [previousButton, pageControle, nextButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomStackView.distribution = .fillEqually
        
        view.addSubview(bottomStackView)
        
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func setLayout(){
        
        //toplayout
        let topImagecontainerView = UIView()
//        topImagecontainerView.backgroundColor = .blue
        view.addSubview(topImagecontainerView)
        //enable this
        topImagecontainerView.translatesAutoresizingMaskIntoConstraints = false
        topImagecontainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImagecontainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImagecontainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImagecontainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        //bear Image
        topImagecontainerView.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImagecontainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImagecontainerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImagecontainerView.heightAnchor, multiplier: 0.5).isActive = true

        
        // title text
        titleTextView.topAnchor.constraint(equalTo: topImagecontainerView.bottomAnchor).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor{
    
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    static var lowPink =  UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
    
}
