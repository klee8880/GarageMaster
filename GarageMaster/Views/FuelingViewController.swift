//
//  FuelingViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 3/3/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

//MARK: - Table Cell
class UIFuelingCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class FuelingViewController: UITableViewController {
    var detail: VehicleData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detail = self.detail { return detail.fueling.count }
        else{ return 0 }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fuelingData", for: indexPath) as! UIFuelingCell

        // Configure the cell...
        if let fueling = self.detail?.fueling[indexPath.row] {
            if let price = fueling.price{
                cell.costLabel.text = "$\(price)"
            }
            
            if let date = fueling.date{
                let df = DateFormatter()
                df.dateFormat = "dd/mm/yy"
                cell.dateLabel.text = df.string(for: date)
            }
            
            if let volume = fueling.volume{
                var tag = ""
                switch detail!.type{
                case.petroleum:
                    tag = "Gal"
                    break;
                case.diesel:
                    tag = "Gal"
                    break;
                case.electric:
                    tag = "Mwh"
                    break;
                default:
                    break;
                }
                cell.volumeLabel.text = "\(volume) " + tag
            }
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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
