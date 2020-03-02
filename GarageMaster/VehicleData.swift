//
//  VehicleData.swift
//  GarageMaster
//
//  Created by Steven Lee on 2/26/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import Foundation

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

// MARK: - Vehicle Data

class VehicleData{
    enum VehicleType{
        case petroleum
        case diesel
        case electric
        case mechanical
    }
    
    var title: String = "PlaceHolderTitle"
    var liscense: String = "PlaceHolderLiscense"
    var vin: String = "VinNumber"
    var type: VehicleType = VehicleType.petroleum
    var capacity: Float?
    var mileage: Float?
    var efficiency: Float?
    var maxRange: Float? {
        if capacity == nil || efficiency == nil {return nil}
        return capacity! * efficiency!
    }
    var schedules: [maintinanceSchedule] = []
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


