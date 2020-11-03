//
//  MainViewModel.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/30/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation
import CoreLocation

class MainViewModel {
    
    var objArray : [NSDictionary] = []
    let getLocation = GetLocation()
    var jobsDistanceView: String = ""
  
    private var basedUrl: String = "https://temper.works/api/v1/contractor/shifts?dates=2020-10-30"
    
    var curentDate: String {
        //set todays date
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE d MMMM"
        let dateString = df.string(from: date)
        return dateString
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
       }
       
    func downloadImage(from url: URL) {
           print("Download Started")
           
    }
    
    
    
}


extension MainViewModel{
    
    func getBaseURL() -> String{
        return basedUrl
    }
    
    func getLocationDistance(job_lng: String, job_lat: String) -> String{
        
        let location2:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Double((job_lng as NSString).doubleValue), longitude: Double((job_lat as NSString).doubleValue))
        
        getLocation.run {
            if let location = $0 {
            let coordinate1 = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let coordinate2 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)

            let distanceInMeters = coordinate1.distance(from: coordinate2)
            print("location ---->",round(distanceInMeters/1000))
            self.jobsDistanceView = " \(round(distanceInMeters/1000))KM"
            } else {
                print("Get Location failed \(String(describing: self.getLocation.didFailWithError))")
                }
            }
        return jobsDistanceView
    }
    
}
