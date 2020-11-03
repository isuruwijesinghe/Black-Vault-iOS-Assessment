//
//  TableViewCell.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 11/1/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var job: Job?{
        didSet{
            guard let unwrappedJob = job else {
                return
            }
            
            JobsTitleTextView.text = unwrappedJob.title
            JobsDestanceTextView.text = unwrappedJob.destance
            JobsPriceTextView.text = unwrappedJob.price
            JobsTimeTextView.text = unwrappedJob.time
            
            let url = URL(string: unwrappedJob.image )!
            downloadImage(from: url)
            getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.JobsImageView.contentMode = .scaleAspectFill
                self?.JobsImageView.image = UIImage(data: data)
                }
            }
            
        }
    }
    
    //image View
    private let JobsImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bearImage"))
        // you must enable this to put autolayouts
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width/19.0
        return imageView
    }()
    
    //destance and job category
    private let JobsDestanceTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .purple
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Service . 16 KM"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    //job name text
    private let JobsTitleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "The Service Name"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    //job time text
    private let JobsTimeTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = "10.00 - 24.00"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    //job price text
    private let JobsPriceTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = "$ 100"
        textView.textAlignment = .right
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.layer.maskedCorners = [.layerMinXMinYCorner]
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
       
    func downloadImage(from url: URL) {
           print("Download Started")
           
    }
    
    fileprivate func setLayout(){
        
        //toplayout
        let topImagecontainerView = UIView()
        addSubview(topImagecontainerView)
        topImagecontainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topImagecontainerView.topAnchor.constraint(equalTo: topAnchor),
            topImagecontainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImagecontainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImagecontainerView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        addSubview(JobsImageView)
        NSLayoutConstraint.activate([
            JobsImageView.topAnchor.constraint(equalTo: topImagecontainerView.topAnchor),
            JobsImageView.leadingAnchor.constraint(equalTo: topImagecontainerView.leadingAnchor),
            JobsImageView.trailingAnchor.constraint(equalTo: topImagecontainerView.trailingAnchor),
            JobsImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        addSubview(JobsDestanceTextView)
        NSLayoutConstraint.activate([
            JobsDestanceTextView.topAnchor.constraint(equalTo: JobsImageView.bottomAnchor),
            JobsDestanceTextView.leadingAnchor.constraint(equalTo: topImagecontainerView.leadingAnchor),
            JobsDestanceTextView.trailingAnchor.constraint(equalTo: topImagecontainerView.trailingAnchor)
        ])
        
        addSubview(JobsTitleTextView)
        NSLayoutConstraint.activate([
            JobsTitleTextView.topAnchor.constraint(equalTo: JobsDestanceTextView.bottomAnchor),
            JobsTitleTextView.leadingAnchor.constraint(equalTo: topImagecontainerView.leadingAnchor),
            JobsTitleTextView.trailingAnchor.constraint(equalTo: topImagecontainerView.trailingAnchor)
        ])
        
        addSubview(JobsTimeTextView)
        NSLayoutConstraint.activate([
            JobsTimeTextView.topAnchor.constraint(equalTo: JobsTitleTextView.bottomAnchor),
            JobsTimeTextView.leadingAnchor.constraint(equalTo: topImagecontainerView.leadingAnchor),
            JobsTimeTextView.trailingAnchor.constraint(equalTo: topImagecontainerView.trailingAnchor)
        ])
        
//        JobsPriceTextView.layer.masksToBounds = true
//        roundCorners(view: JobsPriceTextView, corners: [.topLeft], radius: 10.0)

        addSubview(JobsPriceTextView)
        NSLayoutConstraint.activate([
            JobsPriceTextView.bottomAnchor.constraint(equalTo: JobsImageView.bottomAnchor),
            JobsPriceTextView.trailingAnchor.constraint(equalTo: topImagecontainerView.trailingAnchor),
            JobsPriceTextView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    
}


