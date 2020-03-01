//
//  VehicleViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 2/29/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

class VehicleViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var liscense: UITextField!
    @IBOutlet weak var vin: UITextField!
    @IBOutlet weak var odometer: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var capacity: UITextField!
    @IBOutlet weak var efficiency: UITextField!
    @IBOutlet weak var totalRange: UILabel!
    @IBOutlet weak var policyCompany: UITextField!
    @IBOutlet weak var policyNumber: UITextField!
    @IBOutlet weak var policyDate: UIDatePicker!
    @IBOutlet weak var policyPhone: UITextField!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            name.text = detail.title
            liscense.text = detail.liscense
            vin.text = detail.vin
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: VehicleData? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}
