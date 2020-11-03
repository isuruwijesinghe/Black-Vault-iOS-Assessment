//
//  MainTableViewModel.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 11/2/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit
import CoreLocation


class MainTableViewModel {
    
    var objArray : [NSDictionary] = []
    let getLocation = GetLocation()
    var jobsDistanceView: String = ""
    private var basedUrl: String = "https://temper.works/api/v1/contractor/shifts?dates=2020-11-02"
    
    private var tableView = UITableView()
    
    var curentDate: String {
        //set todays date
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE d MMMM"
        let dateString = df.string(from: date)
        return dateString
    }
    
    func getBaseURL() -> String{
        return basedUrl
    }
    
    func setTable(table: UITableView) {
        tableView = table
    }
    
    func getArrayData() -> [NSDictionary]{
        if objArray.isEmpty{
            print("array is empty")
            return objArray
        }else{
            return objArray
        }
    }
    
    func getLocationDistance(job_lng: String, job_lat: String) -> String{
        
        let location2:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((job_lng as NSString).doubleValue), longitude: Double((job_lat as NSString).doubleValue))
        
        getLocation.run {
            if let location = $0 {
            let coordinate1 = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinate2 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)

            let distanceInMeters = coordinate1.distance(from: coordinate2)
//            print("location ---->",round(distanceInMeters/1000))
            self.jobsDistanceView = " \(round(distanceInMeters/1000))KM"
            } else {
                print("Get Location failed \(String(describing: self.getLocation.didFailWithError))")
                }
            }
        return jobsDistanceView
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
//                        print(json)
                        let applicationStateJson = json["data"] as? NSDictionary
                        self.objArray = (applicationStateJson?["2020-11-02"] as? [NSDictionary])!
                                        
                        DispatchQueue.main.async{
                            //reload table
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
    
    
}
