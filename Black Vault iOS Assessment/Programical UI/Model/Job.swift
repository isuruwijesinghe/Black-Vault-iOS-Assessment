//
//  Job.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 11/2/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation

//struct Job {
//
//    let jobs: [NSDictionary]
//
//}

class Job{
    
    var title: String = ""
    var destance: String = ""
    var image: String = ""
    var price: String = ""
    var time: String = ""
    
    init(title: String, destance:String, image:String, price:String, time:String) {
        self.title = title
        self.destance = destance
        self.image = image
        self.price = price
        self.time = time
    }
    
}
