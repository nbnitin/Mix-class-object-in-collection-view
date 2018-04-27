//
//  EventModel.swift
//  Aliyah Media
//
//  Created by Nitin Bhatia on 15/01/18.
//  Copyright © 2018 Nitin Bhatia. All rights reserved.
//

import Foundation

class EventModel{
    let id : Int
    let title : String
    let date: String
    let details : String
    let image : String
    let shareLink : String
    
    init(id: Int, title : String, date : String, details : String, image : String, shareLink: String){
        self.id = id
        self.title = title
        self.date = date
        self.details = details
        self.image = image
        self.shareLink = shareLink
    }
}

//Event Model Details
class EventModelDetails:EventModel{
    let venue: String
    let street: String
    let state: String
    let startTime: String?
    let endDate: String?
    let endTime: String?
    let city : String?
    let country : String?
    
    init(venue:String,street:String,state:String,endDate:String,endTime:String,startTime:String,city:String,country:String,eve:EventModel){
        self.venue = venue
        self.street = street
        self.state = state
        self.endDate = endDate
        self.endTime = endTime
        self.startTime = startTime
        self.city = city
        self.country = country
        
        super.init(id: eve.id, title: eve.title, date: eve.date, details: eve.details, image: eve.image,shareLink: eve.shareLink)
    }
}

