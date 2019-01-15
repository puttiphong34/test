//
//  ViewController2.swift
//  app1
//
//  Created by Promptnow on 8/1/2562 BE.
//  Copyright © 2562 Promptnow. All rights reserved.
//

import UIKit
import FirebaseFirestore
struct callData {
    var open = Bool()
    var title = String()
    var sectionData = [String]()
}
class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableData = [callData]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let docRef = Firestore.firestore().collection("Promptnow").document("ing")
        docRef.getDocument { (document, err) in
            if let document = document {
    
                self.tableData = [callData(open: false, title: "Title1", sectionData: ["call", "call2", "call3"]),
                     callData(open: false, title: "Title2", sectionData: ["call", "call2", "call3"]),
                     callData(open: false, title: "Title3", sectionData: ["call", "call2", "call3"])]
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData[section].open == true {
            return tableData[section].sectionData.count + 1
            
        }else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text = tableData[indexPath.section].title
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text = tableData[indexPath.section].sectionData[dataIndex]

            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableData[indexPath.section].open == true {
                tableData[indexPath.section].open = false
            

                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                tableData[indexPath.section].open = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            
        }
    }

}
