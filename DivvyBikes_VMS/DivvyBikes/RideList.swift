//
//  RideList.swift
//  DivvyBikes
//  Model class for Ride List
//  Created by Vijay Murugappan Subbiah on 11/28/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class RideList: NSObject {
    var name: String!
    var short_desc: String!
    var long_desc: String!
    var short_image: UIImage!
    var large_image: UIImage!
    
    init(trailName: String, descS: String, descF: String, imageS: UIImage, imageL: UIImage) {
        name = trailName
        short_desc = descS
        long_desc = descF
        short_image = imageS
        large_image = imageL
    }
}
