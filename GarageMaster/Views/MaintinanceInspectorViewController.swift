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
    
    var detail: VehicleData?
    var category: maintinanceSchedule?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toolbar.items?.insert(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), at: 0)
        
        if let category = category{
            titleField.text = category.name
            
            if let mileDue = category.nextmileDue{
                mileField.text = "\(mileDue)"
            }
            else{
                mileField.text = ""
            }
            
            if let dateDue = category.nextDateDue{
                datePicker.date = dateDue
            }
            
            oneTimeSwitch.isOn = category.oneTime
        }
    }
    
    @IBAction func deleteCategory(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Category", message: "Deleting a maintinace category is perminant", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Continue", style: .default) {(_) in
            
            if self.detail == nil {return}
            
            if let index = self.detail!.schedules.firstIndex(where: {(schedule) in return schedule === self.category!}){
                self.detail!.schedules.remove(at: index)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive){(_) in}
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func touchBackground(_ sender: Any) {
        titleField.resignFirstResponder()
        mileField.resignFirstResponder()
        updateCategory()
    }
    
    @IBAction func exitField(_ sender: UITextField) {
        updateCategory()
    }
    
    @IBAction func newDate(_ sender: UIDatePicker) {
        guard let category = category else{return}
        category.nextDateDue = datePicker.date
    }
    
    @IBAction func eventSwitched(_ sender: Any) {
        updateCategory()
    }
    func updateCategory(){
        if let category = category {
            if let title = titleField.text{
                category.name = title
            }
            
            category.nextDateDue = datePicker.date
            
            category.oneTime = oneTimeSwitch.isOn
            
            if let mile = mileField.text{
                if mile == "" {return}
                if let decimal = Float(mile){
                    category.nextmileDue = decimal
                }
            }
        }
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
            
            cell.descriptionLabel.text = event.description
            
            if let date = event.date{
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "dd/MM/yyyy"
                cell.dateLabel.text = "\(dateFormat.string(from: date))"
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
    @IBOutlet weak var descriptionLabel: UILabel!
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
