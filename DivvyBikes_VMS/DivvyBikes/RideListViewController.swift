//
//  RideListViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 11/28/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class RideListViewController: UITableViewController {
    
    //OBJECT HANDLERS
    var rideLists = [RideList]()
    
    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.navigationController?.tabBarItem.title //Setting navigation bar title to the same as tab bar item title
        readPlist() // read plist data
        tableView.reloadData() // reload table view data
    }
    
    //VIEW DID APPEAR - View when it is prepared to display to the user
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData() // reload table view data
    }
    
    func readPlist() {
        let path = Bundle.main.path(forResource: "PopularRideList", ofType: "plist")! // Getting the path for the plist file
        let rideList = NSArray(contentsOfFile:path) as? [[String:Any]] // Accessing Array of ride lists
        for dictionary in rideList! { // dictionary in array
            //print(dictionary)
            let name = dictionary["name"] as? String
            //print(name ?? 0)
            let small_image = dictionary["image"] as? String
            //print(small_image ?? 0)
            let large_image = dictionary["large_image"] as? String
            //print(large_image ?? 0)
            let full_desc = dictionary["full_desc"] as? String
            //print(full_desc ?? 0)
            let short_desc = dictionary["short_desc"] as? String
            //print(short_desc ?? 0)
            let smallImg = loadImage(_SString: small_image!)
            let largeImg = loadImage(_SString: large_image!)
            //print(name ?? 0,smallImg,largeImg,short_desc ?? 0,full_desc ?? 0)
            rideLists.append(RideList(trailName: name!, descS: short_desc!, descF: full_desc!, imageS: smallImg, imageL: largeImg)) // storing all the retreived information to the model class
            tableView.reloadData() // reloading table data after storing
        }
        rideLists.sort { //sorting according to name
            return $0.name < $1.name
        }
    }
    
    //loading image and returning it back to the table
    func loadImage(_SString:String) -> UIImage {
        let urlImage = UIImage(named: _SString)
        return urlImage!
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 //1 section in tableview
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rideLists.count // dynamic creation of rows depending on the model count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RideListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RideListTableViewCell
        let list:RideList = rideLists[indexPath.item] // object for the class
        cell.cellImageView.image = list.short_image
        cell.titleLabel.text = list.name
        cell.subTitleText.text = list.short_desc
        return cell
    }
    
    //this functions gets called when clicked a table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ridedetail", sender: self)
    }
    
    // this function will get called before the control is handed over to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ridedetail" {
            let rideVC = segue.destination as! DivvyRideListViewController
            if let indexPath = tableView.indexPathForSelectedRow { // getting the table view cell index
                let ride:RideList = rideLists[indexPath.item]
                rideVC.navigationItem.title = ride.name
                rideVC.image = ride.large_image
                rideVC.subText = ride.short_desc
                rideVC.longText = ride.long_desc
            }
        }
    }
}
