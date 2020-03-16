//
//  MaintinanceViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 3/3/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

//MARK: - Table Cell
class UIMaintCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var foreground: UIView!
    
    var progress: Float? = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var scale: CGFloat = CGFloat(1)
        
        if let progress = progress {
            scale = background.frame.width * CGFloat(progress) - 30
        }
        
        foreground.frame = CGRect(x: foreground.frame.origin.x, y: foreground.frame.origin.y, width: scale, height: foreground.frame.height)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class MaintinanceViewController: UITableViewController {
    var detail: VehicleData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        if let detail = self.detail {
            detail.schedules.insert(maintinanceSchedule(), at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detail = self.detail{ return detail.schedules.count }
        else{ return 0 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maintinanceCell", for: indexPath) as! UIMaintCell
        // Configure the cell...
        if let category = detail?.schedules[indexPath.row]{
            cell.categoryLabel.text = category.name
            cell.progress = category.expiration(date: Date(), mileage: detail!.mileage)
        }
        return cell
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

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        switch segue.identifier{
        case "maintinanceInspector":
            guard let index = tableView.indexPathForSelectedRow else {return}
            
            if let inspector = segue.destination as? MaintinanceInspectorViewController {
                inspector.category = detail?.schedules[index.row]
            }
            return
        default:
            return
        }
    }
    
    

}
