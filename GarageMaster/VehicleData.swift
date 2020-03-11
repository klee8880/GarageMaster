//
//  VehicleData.swift
//  GarageMaster
//
//  Created by Steven Lee on 2/26/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import Foundation

// MARK: - Fueling Data
class FuelingEvent {
    var distance: Float?
    var price: Float?
    var volume: Float?
    var date: Date?
    
    init(){
        
    }
    
    init( distance:Float, price:Float, volume:Float){
        self.distance = distance
        self.price = price
        self.volume = volume
    }
}

// MARK: - Maintinance Data

class maintinanceSchedule{
    enum scheduleType{
        case oneTime
        case recurring
    }
    
    var name: String = "New Event"
    var type: scheduleType = .oneTime
    var nextDateDue: Date?
    var nextmileDue: Float?
    var History: [maintinanceEvent] = [maintinanceEvent(nil, nil, 4000), maintinanceEvent(nil, nil, 5000), maintinanceEvent(nil, nil, 6000), maintinanceEvent(nil, nil, 7000)]
    
    init (){}
    init (name: String, type: scheduleType){
        self.name = name
        self.type = type
    }
    
    func dueSoon(odometer: Float) -> Bool{
        if let mile = nextmileDue {
            if (mile - odometer) < 750 {return true}
        }
        return false
    }
    
    func dueSoon(date: Date) -> Bool{
        if let dueDate = nextDateDue {
            if (date.timeIntervalSince(dueDate)) < 30 {return true}
        }
        return false
    }
}

class maintinanceEvent {
    var mileage: Int?
    var date: Date?
    var cost: Float?
    
    init () {}
    init (_ mileage: Int?,_ date: Date?,_ cost: Float?) {
        self.mileage = mileage
        self.date = date
        self.cost = cost
    }
}

// MARK: - Vehicle Type
enum VehicleType: Int{
    case petroleum = 0
    case diesel = 1
    case electric = 2
    case mechanical = 3
}

// MARK: - Vehicle Data

class VehicleData{
    
    var title: String = "New Vehicle"
    var liscense: String = ""
    var vin: String = ""
    var type: VehicleType = VehicleType.petroleum
    var capacity: Float?
    var mileage: Float?
    var efficiency: Float?
    var maxRange: Float? {
        if capacity == nil || efficiency == nil {return nil}
        return capacity! * efficiency!
    }
    var schedules: [maintinanceSchedule] = [maintinanceSchedule(name: "Miscellaneous", type: .oneTime)]
    var fueling: [FuelingEvent] = []
    var company: String = "N/A#"
    var policyNumber: String = "N/A#"
    var endDate: Date?
    var phoneNumber: String = "N/A#"
    
    init(){}
    
    init(title: String, mileage: Float, efficiency: Float, capacity: Float, type: VehicleType){
        self.title = title
        self.type = type
        self.mileage = mileage
        self.efficiency = efficiency
        self.capacity = capacity
    }
    
}


