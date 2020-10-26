//
//  SecondViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/25/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    let basedUrl: String = "https://angulartesting-8cd5c.firebaseio.com/content.json"
    var objArray : [NSDictionary] = []
    var tableObjArray : [NSDictionary] = []
    
    var indexNumber: Int = 0
    
    var job_image = "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/186540.jpg"
    
    
    var whichCollectionViewScrolled = "" {
        willSet{
            print(newValue)
        }
    }

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.tag = 1
        tableView.tag = 2
        
        collectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryCollectionCell")
        
        tableView.rowHeight = 320
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        getData(from: basedUrl)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionCell", for: indexPath) as! StoryCollectionViewCell
        cell.storyLabel.text = objArray[indexPath.row].value(forKey: "date") as? String
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if objArray.isEmpty{
            return 0
        }else{
            tableObjArray = objArray[indexNumber].value(forKey: "content") as! [NSDictionary]
            print("obj count ",tableObjArray.count)
            return tableObjArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.JobNameView.text = tableObjArray[indexPath.row].value(forKey: "title") as! String
        
        
        let job_imageX = tableObjArray[indexPath.row].value(forKey: "photo") ?? "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/186540.jpg"
        
        let url = URL(string: job_imageX as! String )!
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
//           print("Download Started")
           
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
//                        print(json.count)
                        self.objArray = json as? [NSDictionary] ?? []
                        self.tableObjArray = self.objArray[0].value(forKey: "content") as! [NSDictionary]
//                        let applicationStateJson = json["cotent"] as? NSDictionary
//                        print(self.objArray.count)
//                        self.objArray = (applicationStateJson?["2020-10-26"] as? [NSDictionary])!
                                        
                        DispatchQueue.main.async{
                            //reload table
                            self.collectionView.reloadData()
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    

                }).resume()
                
                
                
            }

}

extension SecondViewController: UIScrollViewDelegate {
func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    

    if let collectionView = scrollView as? UICollectionView {
        
        let index = Int(collectionView.contentOffset.x / (collectionView.bounds.size.width/2))
        print("collectionview index", index)
        indexNumber = index
        tableView.reloadData()
        
        

    }else if let tableView = scrollView as? UITableView{
        
        print("TableView", tableView.tag)
        
        let height = tableView.frame.size.height
        let contentYoffset = tableView.contentOffset.y
        let distanceFromBottom = tableView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            print(" you reached end of the table")
            if objArray.count != indexNumber+1{
                indexNumber += 1
                collectionView.selectItem(at: [0, indexNumber], animated: false, scrollPosition: .centeredHorizontally)
                collectionView.reloadData()
                tableView.reloadData()
            }else{
                indexNumber = 0
                collectionView.selectItem(at: [0, indexNumber], animated: false, scrollPosition: .centeredHorizontally)
                collectionView.reloadData()
                tableView.reloadData()
            }
            
        }
        
    }else{
        print("cant cast")
    }
}
}
