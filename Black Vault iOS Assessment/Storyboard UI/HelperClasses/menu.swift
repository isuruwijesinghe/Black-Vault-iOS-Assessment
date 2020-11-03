//
//  menu.swift
//  Black Vault iOS Assessment
//
//  Created by Isuru Wijesinghe on 10/26/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation

class Menu{
    
    var title: String = ""
    var names: [String] = []
    var image: [String] = []
    
    init(title: String, names:[String], image:[String]) {
        self.title = title
        self.names = names
        self.image = image
    }
    
}
