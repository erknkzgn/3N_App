//
//  MainTableVC.swift
//  3N
//
//  Created by Erkan Kızgın on 26.09.2022.
//

import UIKit
import Firebase

class MainTableVC: UITableViewController {
    
    var ref:  DatabaseReference?
    var alertController: UIAlertController!
    
    @IBOutlet var tableView1: UITableView!
    let cellID = "categoryCell"
    var data: [String:AnyObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getAllData()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: cellID)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var count: Int = 1
        if let data = data {
            count = data.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in
            if let data = self.data {
                FirebaseOperations(ref: self.ref!).delete(child: (Array(data)[indexPath.row].key))
                self.getAllData()
                tableView.reloadData()
            }
            
        })
        return UISwipeActionsConfiguration(actions: [delete])
                                        
        }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CategoryTableViewCell
        print("\(indexPath.row)")
        if let data = data {
            cell.title.text =  Array(data)[indexPath.row].value["category_name"] as? String
        }
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "CheckListSegue", sender: MainTableVC.self)
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        presentAlert(title: "Add Category", message: "Write your category.", preferredStyle: .alert, defaultButtonTitle: "Ekle", cancelButtonTitle: "Cancel", isAddInputField: true, inputFieldCount: 2, inputFieldsPlaceHolder: ["Category Name","Rate"], defaultButtonHandler: { _ in
            let category = self.alertController.textFields?.first?.text
            let rate     = self.alertController.textFields?[1].text
            FirebaseOperations(ref: self.ref!).add(name: category! , rate: rate!)
        })
        
        
    }
}

extension MainTableVC {
    
    func getAllData(){
        FirebaseOperations(ref: ref!).getAllData() { [weak self] data in
            guard let self = self else {
                return
            }
            self.data = data
            self.tableView.reloadData()
        }
    }
    
    func presentAlert(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style,
                      defaultButtonTitle: String? = nil,
                      cancelButtonTitle: String?,
                      isAddInputField: Bool = false,
                      inputFieldCount: Int,
                      inputFieldsPlaceHolder: [String],
                      defaultButtonHandler: ((UIAlertAction) -> Void)? = nil) {
        
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if isAddInputField {
            for _ in 0..<inputFieldCount {
                self.alertController.addTextField()
            }
        }
        
        for i in 0..<inputFieldsPlaceHolder.count {
            self.alertController.textFields?[i].placeholder = inputFieldsPlaceHolder[i]
        }
        
        
        if defaultButtonTitle != nil{
            let defaultButton = UIAlertAction(title: defaultButtonTitle,
                                              style: .default,
                                              handler: defaultButtonHandler)
            alertController.addAction(defaultButton)
        }
        
        let cancelButton = UIAlertAction(title: cancelButtonTitle,
                                       style: .cancel)
        
        
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
    }

}
