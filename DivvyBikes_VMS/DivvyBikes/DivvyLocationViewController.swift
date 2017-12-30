//
//  DivvyLocationViewController.swift
//  DivvyBikes
//  This Application shows you how a divvy bike works. This app will locate nearest divvy bike station to you in a map which directs us to a detail view where we can find the info,pricing which redirects to the website and navigation to the nearest station. Fetching data takes place using GCD
//  Created by Vijay Murugappan Subbiah on 11/26/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit
import MapKit // Importing mapkit for mapview

// Referencing map view delegate for placing pins in the map view and location manager delegate for getting user location
class DivvyMapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    //OUTLETS
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityAnimation: UIActivityIndicatorView!
    
    //OBJECT HANDLERS
    var stations = [DivvyStations]()
    var currentStation:DivvyStations! // object for current station
    
    //VARIABLES
    var inactiveQueue: DispatchQueue!
    let queueDivvy = DispatchQueue(label: "edu.cs.niu.queueDivvy") // Creating a dispatch queue
    var is_active = Bool() // variable to check whether the current station is active or not
    var index = Int() // for differentiating each annotation
    var manager = CLLocationManager() // object of class location manager to update user location
    
    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        activityAnimation.isHidden = true // hides the activity indicator at beginning
        if let queue = inactiveQueue { // Activates the queue at the application level
            queue.activate()
        }
        queueDivvy.sync { // Executing simple sync queue to retreive divvy station data from web api
            retreiveStations() // retreiving divvy station data from web api
        }
        self.navigationItem.title = self.navigationController?.tabBarItem.title //Setting navigation bar title to the same as tab bar item title
        showUserLocation() // to show user location in the map view
        // Do any additional setup after loading the view.
    }
    
    // USER DEFINED FUNCTIONS
    
    func showUserLocation() {
        /* this function updates the user location in the map view */
        manager.delegate = self // setting location manager delegate to the view controller
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func retreiveStations() {
        /* Making GET request to the url and retreiving all the divvy station data, parsing those json data and storing them in the model */
        let url = URL(string: "https://feeds.divvybikes.com/stations/stations.json") //URL for the json data
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        activityAnimation.isHidden = false // bringing out the activity indicator
        activityAnimation.startAnimating() // start animating while fetching the data from url
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data,response,error) in
            self.activityAnimation.stopAnimating() // stops animating when the data is fetched from the url
            self.activityAnimation.isHidden = true // hiding back the activity indicator
            if error != nil { // if fetch error - error checking
                self.showAlert(Title: "CONNECTION ERROR", Desc: (error?.localizedDescription)!) // producing alert for error in connecting
            }
            else {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any] // json parsing the data received
                    let jsonArray = jsonObj["stationBeanList"] as! [[String:AnyObject]] // Parsing array in json
                    for jsonData in jsonArray { // Json parsing all the variables in array and storing them
                        let station_name = jsonData["stationName"] as! String
                        let available_docks = jsonData["availableDocks"] as! Int
                        let total_docks = jsonData["totalDocks"] as! Int
                        let latitude = jsonData["latitude"] as! CLLocationDegrees
                        let availableBikes = jsonData["availableBikes"] as! Int
                        let longitude = jsonData["longitude"] as! CLLocationDegrees
                        let stAddress = jsonData["stAddress1"] as! String
                        let city = jsonData["city"] as! String
                        let postalCode = jsonData["postalCode"] as! String
                        let lastCommunicationTime = jsonData["lastCommunicationTime"] as! String
                        let is_renting = jsonData["is_renting"] as! Bool
                        let status_active = jsonData["status"] as! String
                        if(status_active == "IN_SERVICE") { // checking if status is active and setting the flag
                            self.is_active = true
                        }
                        else { // if inactive sets the flag to false
                            self.is_active = false
                        }
                        let stationDistance = self.calculateDistance(latitude: latitude, longitute: longitude) //calculating distance for user location
                        self.stations.append(DivvyStations(name: station_name, avlDocks: available_docks, totDocks: total_docks, lat: latitude, long: longitude, avlBikes: availableBikes, st: stAddress, citystation: city, zipstation: postalCode, commTime: lastCommunicationTime, rentalStatus: is_renting, stationStatus: self.is_active, dist: stationDistance)) // storing all the retreived information to the model class
                        DispatchQueue.main.async { // main queue
                            self.setMapView(lat: latitude, long: longitude, title: station_name, subTitle:availableBikes, status: self.is_active) // setting the map view after storing information to model class
                        }
                    }
                }
                catch {
                    self.showAlert(Title: "JSON PARSING ERROR", Desc: error.localizedDescription) // producing alert for error in JSON parsing
                }
            }
        }
        task.resume() // resuming the data task
    }
    
    func showAlert(Title: String, Desc: String) {
        /* Producing alerts for specific error title and description with an action to dismiss the controller */
        let alertController = UIAlertController(title: Title, message: Desc, preferredStyle: .alert) // alert controller
        let alertAction = UIAlertAction(title: "OK", style: .default) { // completion handler for alert action
            (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction) // adding action to controller
        self.present(alertController, animated: true, completion: nil) // presenting alert controller
    }
    
    func calculateDistance(latitude: CLLocationDegrees, longitute: CLLocationDegrees) -> Double {
        let currentLocation = CLLocation(latitude: 41.878876, longitude: -87.635915) // dummy user location
        let stationLocation = CLLocation(latitude: latitude, longitude: longitute) // location of the divvy station
        let distance = (stationLocation.distance(from: currentLocation)) * 0.000621371192 // calculating distance from user to divvy station
        return distance.rounded(toPlaces: 2) // rounding of to two decimal digits
    }
    
    func setMapView(lat: CLLocationDegrees, long: CLLocationDegrees, title: String, subTitle: Int, status: Bool) {
        mapView.mapType = .hybrid // setting map  type to hybrid
        let objectAnimation = CustomPointAnnotation() // creating object for the custom point annotation class
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        objectAnimation.coordinate = pinLocation // set coordinates for pin location
        objectAnimation.title = title // set pin title
        objectAnimation.subtitle = "Available Bikes: \(subTitle)" // set pin sub title
        if status { // if station is active set this pin image
            objectAnimation.pinImage = UIImage(named: "divvy_active")
        }
        else { // if not set this pin image
            objectAnimation.pinImage = UIImage(named: "divvy_inactive")
        }
        objectAnimation.index += 1 // updating index after adding each annotation
        self.mapView.addAnnotation(objectAnimation) // adding annotation to the map view
    }
    
    // MAP VIEW and LOCATION MANAGER DELEGATE METHODS
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation() // after locations are updating stop updating the locations
        let location = locations.last! // set user location
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) // centering on user location
        let span = MKCoordinateSpanMake(0.01, 0.01) // create a span to zoom
        let zoomRegion = MKCoordinateRegion(center: center, span: span) // zoom into the region
        mapView.setRegion(zoomRegion, animated: true) // set region to the map
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        let reuseIdentifier = "pin" // setting reuse identifier
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) // creating a specific view for annotations
        
        if annotationView == nil { // if there is no annotation view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier) // creating a specific view for annotations
            annotationView?.canShowCallout = true // enabling callout for that annotation
        } else {
            annotationView?.annotation = annotation // assign annotations to annotation view
        }
        
        if let customPointAnnotation = annotation as? CustomPointAnnotation { // modify the view of the annotation using a custom class for annotation
            annotationView?.image = customPointAnnotation.pinImage // set pin image for annotation
            let btn = UIButton.init(type: .detailDisclosure) // set ui button for annotaion
            btn.tag = customPointAnnotation.index // assigning pin's index as button tag
            annotationView?.rightCalloutAccessoryView = btn // place the button onto the right callout accessory view
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "detail", sender: view) // navigate to detail view if call out accessory is tapped
    }
    
    // this function will get called before the control is handed over to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" { // if destination id is detail
            if let detailVC = segue.destination as? StationDetailViewController {
                let statName = (sender as! MKAnnotationView).annotation?.title!! // getting the annotation title which is clicked
                for item in 0...stations.count { // searching the title in the station list
                    currentStation = stations[item]
                    if currentStation.stationName == statName { // if matches
                        self.index = item // retreive index
                        break
                    }
                }
                currentStation = stations[index] // index of the current station
                detailVC.navigationItem.title = currentStation.stationName
                detailVC.avlBikes = currentStation.availableBikes
                detailVC.avlDocks = currentStation.availableDocks
                detailVC.totDocks = currentStation.totalDocks
                detailVC.stationStatus = currentStation.isRenting
                detailVC.Street = currentStation.street
                detailVC.City = currentStation.city
                detailVC.roundedDistance = currentStation.distance
                detailVC.reachTime = currentStation.reachTime
                detailVC.lat = String(currentStation.latitude)
                detailVC.long = String(currentStation.longitude)
                if currentStation.zip == "" {
                    detailVC.Zip = ""
                }
                else {
                    detailVC.Zip = currentStation.zip
                }
            }
        }
    }
}

/* REFERENCE: https://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift to round the decimal places to two values */
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
