//
//  MainViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 11/1/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    private let dateTextView: UITextView = {
        let textView = UITextView()
        // you must enable this to put autolayouts
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "this is the date text"
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
        }()
    
    private var datatableView = UITableView()
    
    let viewModel = MainTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        setLabelControlls()
        setButtonControlls()
        setTableControlls()
        
        dateTextView.text = viewModel.curentDate
        
        viewModel.setTable(table: datatableView)
        viewModel.getData(from: viewModel.getBaseURL())
        
       
    }
    
    
    fileprivate func setButtonControlls(){

        let bottomStackView = UIStackView(arrangedSubviews: [signupButton, loginButton])
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        
        view.addSubview(bottomStackView)
        
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func setLabelControlls(){
        
        view.addSubview(dateTextView)
        NSLayoutConstraint.activate([
            dateTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dateTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    fileprivate func setTableControlls(){
        
        datatableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MyCell")
        datatableView.dataSource = self
        datatableView.delegate = self
        
        view.addSubview(datatableView)
        datatableView.backgroundColor = .red
            
        datatableView.translatesAutoresizingMaskIntoConstraints = false
               
    
        NSLayoutConstraint.activate([
            datatableView.topAnchor.constraint(equalTo: dateTextView.bottomAnchor),
            datatableView.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -5),
            datatableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            datatableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
          
        ])
        
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 400
       }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.objArray.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! MainTableViewCell
        
        let shifts = viewModel.objArray[indexPath.row].value(forKeyPath: "shifts") as! [NSDictionary]
        let joblat = viewModel.objArray[indexPath.row].value(forKeyPath: "location.lat") as! String
        let joblng = viewModel.objArray[indexPath.row].value(forKeyPath: "location.lng") as! String
        let job_image = viewModel.objArray[indexPath.row].value(forKey: "photo") ?? "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/153621.jpg"

        
        let jobs = Job(title: (viewModel.objArray[indexPath.row].value(forKey: "title") as? String)!,
            destance: "\(viewModel.objArray[indexPath.row].value(forKeyPath: "job_category.description") ?? "") . \(viewModel.getLocationDistance(job_lng: joblng, job_lat: joblat))KM",
            image: job_image as! String,
            price: "   $ \(shifts[0].value(forKey: "earnings_per_hour") ?? "0")  ",
            time: "\(shifts[0].value(forKey: "start_time") ?? "0") - \(shifts[0].value(forKey: "end_time") ?? "0")"
        )
        cell.job = jobs
      
           return cell
       }
    
    
}
