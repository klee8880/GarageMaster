//
//  AddFuelingViewController.swift
//  GarageMaster
//
//  Created by Steven Lee on 3/8/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import UIKit
//MARK: - Main Body
class AddFuelingViewController: UIViewController {
    @IBOutlet weak var volumeLabel: UITextField!
    @IBOutlet weak var totalLabel: UITextField!
    @IBOutlet weak var odometerLabel: UITextField!
    @IBOutlet weak var dateLabel: UIDatePicker!
    
    var detail: VehicleData?
    var presenter: VehicleViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backgroundTap(_ sender: UIControl) {
        volumeLabel.resignFirstResponder()
        totalLabel.resignFirstResponder()
        odometerLabel.resignFirstResponder()
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
            if label == "" {
                self.invalidInputAlert()
                return
            }
            if let total = Float(label){
                fueling.price = total
            }
        }
        if let label = dateLabel{
            fueling.date = label.date
        }
        if let label = odometerLabel.text{
            if label == "" {
                self.invalidInputAlert()
                return
            }
            if let odo = Float(label){
                detail?.mileage = odo
            }
        }
        
        detail?.fueling.append(fueling)
        
        if let controller = presenter {
            controller.configureView()
            controller.updateMaster()
        }
        
        //Dismiss this view
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//MARK: - Error Alert
    
    func invalidInputAlert(){
        let alert = UIAlertController(title: "Incomplete Information", message: "The indicated fields must be completed before continuing", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default){ (action) in }
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
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
