//
//  VehicleData.swift
//  GarageMaster
//
//  Created by Steven Lee on 2/26/20.
//  Copyright © 2020 Kevin Lee. All rights reserved.
//

import Foundation

// MARK: - Maintinance Data
enum scheduleType{
    case oneTime
    case recurring
}

class maintinanceSchedule {
    var type: scheduleType
    var startDate: Date
    var dateInterval: Int?
    var mileInterval: Int?
    var lastPerformed: Date?
    
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

// MARK: - Insurance Data

class insuranceData {
    var company: String?
    var policyNumber = ""
    var endDate: Date?
}

// MARK: - Vehicle Data
enum VehicleType{
    case petroleum
    case diesel
    case electric
    case mechanical
}

class VehicleData{
    
    var type: VehicleType = VehicleType.petroleum
    var capacity: Float?
    var mileage: Float?
    var efficiency: Float?
    var maxRange: Float? {
        if capacity == nil || efficiency == nil {return nil}
        return capacity! * efficiency!
    }
    var schedules: [maintinanceSchedule] = []
    var VIN: String?
    var insurance: insuranceData?
    
    init(){}
    
    init(mileage: Float, efficiency: Float, capacity: Float, type: VehicleType){
        self.type = type
        self.mileage = mileage
        self.efficiency = efficiency
        self.capacity = capacity
    }
    
}


