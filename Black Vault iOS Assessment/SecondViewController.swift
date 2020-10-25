//
//  SecondViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/25/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    var storyArray: [String] = ["Story 1","Story 2","Story 3","Story 4","Story 5","Story 6","Story 7","Story 8"]
    var postArray: [String] = ["Post 1","Post 2","Post 3","Post 4","Post 5"]
    
    var job_image = "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/186540.jpg"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryCollectionCell")
        
        tableView.rowHeight = 320
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionCell", for: indexPath) as! StoryCollectionViewCell
        cell.storyLabel.text = storyArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == storyArray.count - 1 ) { //it's your last cell
           //Load more data & reload your collection view
            print("Scrolled to the last item")
            job_image = "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/190044.jpg"
            tableView.reloadData()
         }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        
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

}
