//
//  MasterViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 2/26/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

var subjectVehicle: VehicleData?

class MasterViewController: UITableViewController {

    var detailViewController: VehicleViewController? = nil
    var objects = [VehicleData]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        //let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: //#selector(insertNewObject(_:)))
        //navigationItem.rightBarButtonItem = addButton
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? VehicleViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    @IBAction @objc func insertObject(_ sender: Any) {
        objects.insert(VehicleData(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
/*
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = segue.destination as! VehicleViewController
                controller.detailItem = object
                controller.master = self //reference back to me as the master in case of update
                //controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
 */
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UIVehicleCell
        let object = objects[indexPath.row]
        cell.vehicleName!.text = object.title
        cell.license!.text = "License: " + object.liscense
        
        if object.mileage != nil{
            cell.mileage.text = "Mileage: \(object.mileage!)"
        }
        if object.efficiency != nil {
            cell.mpg.text = "MPG: \(object.efficiency!)"
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func refreshTable() {
        self.tableView.reloadData()
    }
}

// MARK: - Car Cell

class UIVehicleCell: UITableViewCell {

    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var license: UILabel!
    @IBOutlet weak var mileage: UILabel!
    @IBOutlet weak var mpg: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

