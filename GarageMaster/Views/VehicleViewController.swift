//
//  VehicleViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 2/29/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

class VehicleViewController: UITableViewController{
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    var editable = false
    
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
    
    @IBOutlet var dataFields: [UITextField]!
    
    var master: MasterViewController? = nil
    var detailItem: VehicleData? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let name = name{
                name.text = detail.title
            }
            if let lisc = liscense{
                lisc.text = detail.liscense
            }
            if let vin = vin{
                vin.text = detail.vin
            }
            if let odo = odometer {
                if detail.mileage == nil{
                    odo.text = ""
                }
                else {
                    odo.text = "\(detail.mileage!)"
                }
            }
            
            if let type = type{
                type.selectedSegmentIndex = detail.type.rawValue
            }

            
            if let cap = capacity{
                if detail.capacity == nil{
                    cap.text = ""
                }
                else {
                cap.text = "\(detail.capacity!)"
                }
            }
            if let efficiency = efficiency {
                if detail.efficiency == nil{
                    efficiency.text = ""
                }
                else{
                    efficiency.text = "\(detail.efficiency!)"
                }
            }
            //only calculate total range if both efficiency & capacity are filled
            if detail.capacity != nil && detail.efficiency != nil{
                if let range = totalRange{
                    range.text = "\(detail.efficiency! * detail.capacity!)"
                }
            }
            if let comp = policyCompany {
                comp.text = detail.company
            }
            if let polNum = policyNumber{
                polNum.text = detail.policyNumber
            }
            if let polDate = policyDate{
                if let date = detail.endDate{
                    polDate.date = date
                }
            }
            if let phone = policyPhone{
                phone.text = detail.phoneNumber
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    @IBAction func EditPush(_ sender: UIBarButtonItem) {
        if editable {
            editable = false
            editButton.title = "Edit"
            for field in dataFields{
                field.isEnabled = false
            }
            type.isEnabled = false
            //TODO: prompt if user wants to save new data
            writeData()
            updateMaster()
        }
        else {
            editable = true
            editButton.title = "Done"
            for field in dataFields{
                field.isEnabled = true
            }
            type.isEnabled = true
        }
    }
    
    func writeData (){
        if let vehicle = detailItem {
            vehicle.title = name.text!
            vehicle.liscense = liscense.text!
            vehicle.vin = vin.text!
            if let mileage = Float(odometer.text!){
                vehicle.mileage = mileage
            }
            
            if let typeSegment = self.type {
                if let type = VehicleType(rawValue: typeSegment.selectedSegmentIndex){
                    vehicle.type = type
                }
            }
            
            if let cap = Float(capacity.text!){
                vehicle.capacity = cap
            }
            else {vehicle.capacity = nil}
            
            if let eff = Float (efficiency.text!){
                vehicle.efficiency = eff
            }
            else {vehicle.efficiency = nil}
            
            vehicle.company = policyCompany.text!
            vehicle.policyNumber = policyNumber.text!
            vehicle.endDate = policyDate.date
            vehicle.phoneNumber = policyPhone.text!
            
        }
        
    }
    
    func updateMaster (){
        master?.refreshTable()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
            
        case "inspectMaintinance":
            (segue.destination as! MaintinanceViewController).detail = detailItem
            return
        case "inspectFueling":
            (segue.destination as! FuelingViewController).detail = detailItem
            return
        case "addFueling":
            let controller = (segue.destination as! AddFuelingViewController)
            controller.detail = detailItem
            controller.presenter = self
            return
        default:
            return
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
