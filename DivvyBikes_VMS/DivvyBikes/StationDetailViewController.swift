//
//  StationDetailViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 11/27/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var avldocksLabel: UILabel!
    @IBOutlet weak var totaldocksLabel: UILabel!
    @IBOutlet weak var avlbikesLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //VARIABLES
    var stationStatus = Bool()
    var avlDocks = Int()
    var totDocks = Int()
    var avlBikes = Int()
    var Street = String()
    var City = String()
    var Zip = String()
    var reachTime = String()
    var roundedDistance = Double()
    var lat = String()
    var long = String()
    
    //ACTION
    // this function gets called when the navigate button is clicked
    @IBAction func directionBtnClicked(sender: UIButton) {
        let url = URL(string: "http://maps.apple.com/maps?daddr=\(lat),\(long)")! // using apple maps api calling this url
        UIApplication.shared.open(url, options: [:], completionHandler: nil) // opening this url to open the apple maps and proceed with the navigation
    }
    
    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView() // updating view with station details
        setImage() // updating image according to the station status
        // Do any additional setup after loading the view.
    }
    
    //USER DEFINED FUNCTIONS
    func updateView() {
        /* updating views with station details from previous map view controller */
        if avlBikes == 0 || avlDocks == 0 { // if available docks or bike is zero
            avldocksLabel.textColor = UIColor.red
            avlbikesLabel.textColor = UIColor.red
        }
        else {
            avldocksLabel.textColor = UIColor.green
            avlbikesLabel.textColor = UIColor.green
        }
        avldocksLabel.text = String(avlDocks)
        totaldocksLabel.text = String(totDocks)
        avlbikesLabel.text = String(avlBikes)
        streetLabel.text = Street
        cityLabel.text = City
        zipLabel.text = Zip
        distanceLabel.text = "\(roundedDistance) mi"
        timeLabel.text = "Updated on \(reachTime)"
    }
    
    func setImage() {
        if stationStatus { // if the station is renting bikes
            imageView.image = UIImage(named: "green_tick")
        }
        else { // if the station is a test station
            imageView.image = UIImage(named: "wrong_red")
        }
    }

}
