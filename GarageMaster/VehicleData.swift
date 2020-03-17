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
    
    //Range used to measure the precentage regurned by the expiration function.
    static var dateRange:Float = 90
    static var mileRange:Float = 1000
    
    //Data fields
    var name: String = "New Event"
    var oneTime: Bool = true
    var nextDateDue: Date?
    var nextmileDue: Float?
    var History: [maintinanceEvent] = []
    
    init (){}
    init (name: String, type: Bool){
        self.name = name
        self.oneTime = type
    }
    
    func expiration(date: Date, mileage: Float?) -> Float?{
        
        if oneTime {return 1}
        
        if nextDateDue != nil && nextmileDue != nil{
            
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: nextDateDue!)
            let date2 = calendar.startOfDay(for: date)
            
            var datePercent = Float((calendar.dateComponents([.day], from: date2, to: date1).day)!)
            datePercent /= maintinanceSchedule.dateRange
            if datePercent > 1 {datePercent = 1}
            else if datePercent < 0 {datePercent = 0}
            
            guard let mile = mileage else {return datePercent}
            
            var milePercent = (nextmileDue! - mile ) / maintinanceSchedule.mileRange
            if milePercent > 1 {milePercent = 1}
            else if milePercent < 0 {milePercent = 0}
            
            if datePercent < milePercent { return datePercent}
            else {return milePercent}
        }
        else if nextDateDue != nil {
            
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: nextDateDue!)
            let date2 = calendar.startOfDay(for: date)
            
            var datePercent = Float((calendar.dateComponents([.day], from: date2, to: date1).day)!)
            datePercent /= maintinanceSchedule.dateRange
            if datePercent > 1 {datePercent = 1}
            else if datePercent < 0 {datePercent = 0}
            
            return datePercent
        }
        else if nextmileDue != nil{
            guard let mile = mileage else {return nil}
            
            var milePercent = (nextmileDue! - mile ) / maintinanceSchedule.mileRange
            if milePercent > 1 {milePercent = 1}
            else if milePercent < 0 {milePercent = 0}
            
            return milePercent
        }
        else {
            return nil
        }
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
    var mileage: Float?
    var date: Date?
    var cost: Float?
    var description: String = ""
    
    init () {}
    init (_ mileage: Float?,_ date: Date?,_ cost: Float?) {
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
    var schedules: [maintinanceSchedule] = [maintinanceSchedule(name: "Miscellaneous", type: true)]
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


