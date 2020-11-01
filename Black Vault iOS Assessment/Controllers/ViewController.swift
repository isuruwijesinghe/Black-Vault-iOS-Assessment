//
//  ViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/16/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var CurrentDateLabel: UILabel!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = MainViewModel()
    
    
    var objArray : [NSDictionary] = []
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //button border and radius
        LoginButton.layer.cornerRadius = 10
        LoginButton.layer.borderWidth = 1
        LoginButton.layer.borderColor = UIColor.black.cgColor
        
       
        CurrentDateLabel.text = viewModel.curentDate
        
        //set cell and row height
        collectionView.register(UINib(nibName: "JobsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "JobsCollectionViewCell")
        

        getData(from: viewModel.getBaseURL())
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobsCollectionViewCell", for: indexPath) as! JobsCollectionViewCell
        cell.JobNameView.text = objArray[indexPath.row].value(forKey: "title") as? String
                
                
        let shifts = objArray[indexPath.row].value(forKeyPath: "shifts") as! [NSDictionary]
        cell.JobsRateView.text = "   $ \(shifts[0].value(forKey: "earnings_per_hour") ?? "0")  "
                
        cell.JobsTimeView.text = "\(shifts[0].value(forKey: "start_time") ?? "0") - \(shifts[0].value(forKey: "end_time") ?? "0")"
                
        let job_image = objArray[indexPath.row].value(forKey: "photo") ?? "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/153621.jpg"
                
        let joblat = objArray[indexPath.row].value(forKeyPath: "location.lat") as! String
        let joblng = objArray[indexPath.row].value(forKeyPath: "location.lng") as! String
            
        cell.JobsDistanceView.text = "\(self.objArray[indexPath.row].value(forKeyPath: "job_category.description") ?? "") . \(viewModel.getLocationDistance(job_lng: joblng, job_lat: joblat))KM"
                
                
            let url = URL(string: job_image as! String)!
            viewModel.downloadImage(from: url)
            viewModel.getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
            cell.JobsImageView.contentMode = .scaleAspectFill
            cell.JobsImageView.image = UIImage(data: data)
                }
            }
        
        return cell
    }
    
    
    // MARK: - Data
        
         func getData(from url: String){
            
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
                
                guard let data = data, error == nil else{
                 print("something wrong")
                    return
                }
                
                //data recieved
                do {
                 let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//                    print(json)
                    let applicationStateJson = json["data"] as? NSDictionary
                    self.objArray = (applicationStateJson?["2020-10-30"] as? [NSDictionary])!
                                    
                    DispatchQueue.main.async{
                        //reload table
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }).resume()
        }
}

