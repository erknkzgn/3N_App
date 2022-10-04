//
//  Categories.swift
//  3N
//
//  Created by Erkan Kızgın on 4.10.2022.
//

import Foundation

class Categories {
    
    var name: String?
    var rate: Int?
    
    init() {
    
    }
    
    init(name: String,rate: Int) {
        self.name = name
        self.rate = rate
    }
}
