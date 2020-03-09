//
//  AddFuelingViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 3/8/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit

class AddFuelingViewController: UIViewController {
    @IBOutlet weak var volumeLabel: UITextField!
    @IBOutlet weak var totalLabel: UITextField!
    @IBOutlet weak var odometerLabel: UITextField!
    @IBOutlet weak var dateLabel: UIDatePicker!
    
    var detail: VehicleData?
    var presenter: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEvent(_ sender: Any) {
        
        let fueling = FuelingEvent()
        
        
        if let label = volumeLabel.text {
            if label == "" {return}
            if let vol = Float(label){
                fueling.volume = vol
            }
        }
        if let label = totalLabel.text{
            if label == "" {return}
            if let total = Float(label){
                fueling.price = total
            }
        }
        if let label = dateLabel{
            fueling.date = label.date
        }
        if let label = odometerLabel.text{
            if label == "" {return}
            if let odo = Float(label){
                detail?.mileage = odo
            }
        }
        
        detail?.fueling.append(fueling)
        
        if let controller = presenter as? VehicleViewController{
            controller.configureView()
            controller.updateMaster()
        }
        
        dismiss(animated: true)
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
