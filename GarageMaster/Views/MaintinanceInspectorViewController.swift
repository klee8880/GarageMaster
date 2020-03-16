//
//  MaintinanceInspectorViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 3/10/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

class MaintinanceInspectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var mileField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var oneTimeSwitch: UISwitch!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var historyTable: UITableView!
    
    var category: maintinanceSchedule?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toolbar.items?.insert(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), at: 0)
    }
    
    @IBAction func deleteCategory(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Category", message: "Deleting a maintinace category is perminant", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Continue", style: .default) {(_) in}
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){(_) in}
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let category = category{
            return category.History.count
        }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "maintinanceCell") as! UIMaintEventCell
        
        if let event = self.category?.History[indexPath.row] {
            if let date = event.date{
                cell.dateLabel.text = "\(date)"
            }
            if let mileage = event.mileage {
                cell.mileLabel.text = "\(mileage) Miles"
            }
            if let price = event.cost {
                cell.priceLabel.text = "$\(price)"
            }
        }
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "maintEventAdd" {
            let view = segue.destination as! AddMaintinanceController
            view.category = category
            view.inspector = self
        }
    }

}

//MARK: - Table Cell

class UIMaintEventCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
