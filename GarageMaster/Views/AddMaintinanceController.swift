//
//  AddMaintinanceController.swift
//  GarageMaster
//
//  Created by Steven Lee on 3/15/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

class AddMaintinanceController: UIViewController {
    @IBOutlet weak var odometerLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet var textFields: [UITextField]!
    
    var category: maintinanceSchedule?
    var inspector: MaintinanceInspectorViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backgroundTouch(_ sender: Any) {
        
        for field in textFields {
            field.resignFirstResponder()
        }
    }
    
    @IBAction func fieldFinished(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func addEvent(_ sender: UIButton) {
        let event = maintinanceEvent()
        if let text = odometerLabel.text{
            if let miles = Float(text){event.mileage = miles}
        }
        
        if let text = priceLabel.text{
            if let price = Float(text){event.cost = price}
        }
        
        if let text = descriptionLabel.text{event.description = text}
        
        if let picker = datePicker{event.date = picker.date}
        
        category?.History.insert(event, at: 0)
        
        //Return to the previous view
        self.navigationController?.popViewController(animated: true)
        self.inspector?.historyTable.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
