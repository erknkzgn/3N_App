//
//  Firebase.swift
//  3N
//
//  Created by Erkan Kızgın on 6.10.2022.
//

import Foundation
import Firebase

class FirebaseOperations {
    
    var ref: DatabaseReference?
    
    init(){
        ref = Database.database().reference()
    }
    
    func getAllData() -> [String:AnyObject]{
        var veri: [String:AnyObject] = [:]
        ref?.child("Categories").observe(.value, with: { Snapshot in
            if let veriButunu = Snapshot.value as? [String:AnyObject] {
                veri = veriButunu
            }
        })
        return veri
    }
    
}
