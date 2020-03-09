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

class maintinanceSchedule {
    enum scheduleType{
        case oneTime
        case recurring
    }
    
    var name: String = ""
    var type: scheduleType
    var startDate: Date
    var dateInterval: Int?
    var mileInterval: Int?
    var lastPerformedDate: Date?
    var lastPerformedMiles: Int?
    
    init(startDate: Date){
        self.startDate = startDate
        type = scheduleType.oneTime
    }
}

class maintinanceEvent {
    var mileage: Int?
    var cost: Int?
    var description: String = ""
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
    var schedules: [maintinanceSchedule] = []
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


