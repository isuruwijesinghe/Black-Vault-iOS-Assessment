//
//  ViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/16/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var CurrentDateLabel: UILabel!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let basedUrl: String = "https://temper.works/api/v1/contractor/shifts?dates=2020-10-23"
    var objArray : [NSDictionary] = []
    
    let getLocation = GetLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //button border and radius
        LoginButton.layer.cornerRadius = 10
        LoginButton.layer.borderWidth = 1
        LoginButton.layer.borderColor = UIColor.black.cgColor
        
        //set todays date
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE d MMMM"
        let dateString = df.string(from: date)
        CurrentDateLabel.text = dateString
        
        //set cell and row height
        tableView.rowHeight = 320;
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        getData(from: basedUrl)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.JobNameView.text = objArray[indexPath.row].value(forKey: "title") as? String
        
        cell.selectionStyle = .none
        
        let shifts = objArray[indexPath.row].value(forKeyPath: "shifts") as! [NSDictionary]
        cell.JobsRateView.text = "   $ \(shifts[0].value(forKey: "earnings_per_hour") ?? "0")"
        
        cell.JobsTimeView.text = "\(shifts[0].value(forKey: "start_time") ?? "0") - \(shifts[0].value(forKey: "end_time") ?? "0")"
        
        let job_image = objArray[indexPath.row].value(forKey: "photo") ?? "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/153621.jpg"
        
        let job_lat = objArray[indexPath.row].value(forKeyPath: "location.lat")
        let job_lng = objArray[indexPath.row].value(forKeyPath: "location.lng")
        
        let location2:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((job_lng as! NSString).doubleValue), longitude: Double((job_lat as! NSString).doubleValue))

        //setting the distance and job category 
        getLocation.run {
            if let location = $0 {
//                print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                 let coordinate1 = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let coordinate2 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)

                 let distanceInMeters = coordinate1.distance(from: coordinate2)
                print("location ---->",round(distanceInMeters/1000))
                cell.JobsDistanceView.text = "\(self.objArray[indexPath.row].value(forKeyPath: "job_category.description") ?? "") . \(round(distanceInMeters/1000))KM"
            } else {
                print("Get Location failed \(self.getLocation.didFailWithError)")
            }
        }
        
        
        let url = URL(string: job_image as! String)!
        downloadImage(from: url)
        getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                cell.JobsImageView.contentMode = .scaleAspectFill
                cell.JobsImageView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        
    }
    
    
    // MARK: - Data
        
        private func getData(from url: String){
            
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
                    self.objArray = (applicationStateJson?["2020-10-23"] as? [NSDictionary])!
                                    
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                    
                }
                

            }).resume()
            
            
            
        }


}

