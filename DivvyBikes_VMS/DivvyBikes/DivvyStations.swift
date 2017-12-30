//
//  DivvyStations.swift
//  DivvyBikes
//  Model class for Divvy Stations
//  Created by Vijay Murugappan Subbiah on 11/27/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit
import MapKit

class DivvyStations: NSObject {
    var stationName: String!
    var availableDocks: Int!
    var totalDocks: Int!
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var availableBikes: Int!
    var street: String!
    var city: String!
    var zip: String!
    var reachTime: String!
    var isRenting: Bool!
    var isActive: Bool!
    var distance: Double!
    
    init(name: String, avlDocks: Int, totDocks: Int, lat: CLLocationDegrees, long: CLLocationDegrees, avlBikes: Int, st: String, citystation: String, zipstation: String, commTime: String, rentalStatus: Bool, stationStatus: Bool, dist: Double) {
        stationName = name
        availableDocks = avlDocks
        totalDocks = totDocks
        latitude = lat
        longitude = long
        availableBikes = avlBikes
        street = st
        city = citystation
        zip = zipstation
        reachTime = commTime
        isRenting = rentalStatus
        isActive = stationStatus
        distance = dist
    }
}
