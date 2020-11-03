//
//  JobTableViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/16/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class JobTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let basedUrl: String = "https://temper.works/api/v1/contractor/shifts?dates=2020-10-16"
    var objArray : [NSDictionary] = []
    
    
    @IBOutlet weak var JobsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JobsTable.delegate = self
        JobsTable.dataSource = self
        
         getData(from: basedUrl)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JobsTableViewCell
        
        for job in self.objArray.enumerated() {

            let job_category = job.element.value(forKeyPath: "job_category.description")
            let job_title = job.element.value(forKey: "title")
            let job_image = job.element.value(forKey: "photo")
            let job_rate = job.element.value(forKeyPath: "shifts.earnings_per_hour") as? String
            
            
            print("job category is here \(job_rate ?? "")")
            
            cell.Cell_JobsNameLabel.text = job_title as? String
            cell.Cell_JobsRateLabel.text = "$ \(job_rate ?? "00.00")"
            cell.Cell_JobsDistanceLabel.text = "\(job_category ?? "") . 16KM"
            
            let url = URL(string: job_image as! String)!
            downloadImage(from: url)
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() { [weak self] in
                    cell.Cell_JobsImageView.image = UIImage(data: data)
                }
            }
            
            
        }
        
        
    
        return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
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
//            print(json)
                let applicationStateJson = json["data"] as? NSDictionary
                self.objArray = (applicationStateJson?["2020-10-16"] as? [NSDictionary])!
                                
                DispatchQueue.main.async{
                    self.JobsTable.reloadData()
                }
            } catch {
                print(error.localizedDescription)
                
            }
            

        }).resume()
        
        
        
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
