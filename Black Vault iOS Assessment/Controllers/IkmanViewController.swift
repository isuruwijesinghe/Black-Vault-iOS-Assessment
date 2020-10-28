//
//  IkmanViewController.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/27/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class IkmanViewController: UIViewController{
    
    var job_image = "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/186540.jpg"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var DescriptionText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DescriptionText.text = "DVD \n Reverse Camera \n Remote key"
        
        let url = URL(string: job_image as! String )!
                    downloadImage(from: url)
                    getImageData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
        //            print(response?.suggestedFilename ?? url.lastPathComponent)
        //            print("Download Finished")
                    DispatchQueue.main.async() { [weak self] in
                        self?.imageView.contentMode = .scaleAspectFill
                        self?.imageView.image = UIImage(data: data)
                        }
                    }
    
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
