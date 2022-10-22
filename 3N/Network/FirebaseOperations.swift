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
    
    init(ref: DatabaseReference){
        self.ref = ref
    }
    
    func getAllData(completion: @escaping ([String : AnyObject]) -> Void) {
        var data: [String:AnyObject] = [:]
        self.ref?.child("Categories").observe(.value, with: { Snapshot in
            print("sa")
            if let veriButunu = Snapshot.value as? [String:AnyObject] {
                for gelenVeri in veriButunu {
                    if let _ = gelenVeri.value as? NSDictionary {
                        data[gelenVeri.key] = gelenVeri.value
                        print("\(data.count)")
                        completion(data)
                    }
                }
                
            }else{
                print("Veri Çekilemedi")
            }
            
        })
    }
    
    func add(name: String, rate: String) {
        let _ = Categories(name: "Camp", rate: 3)
        let dict:[String:Any] = ["category_name": name ,"category_rate": rate]
        let newRef = ref?.child("Categories").childByAutoId()
        newRef?.setValue(dict)
    }
    
    func delete(child: String) {
        let deleteRef = self.ref?.child("Categories").child(child)
        deleteRef?.removeValue {error,_ in
            print(child)
            if let error = error {
                print(error)
            }
        }
    }
    
}
