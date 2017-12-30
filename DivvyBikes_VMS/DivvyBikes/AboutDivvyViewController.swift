//
//  AboutDivvyViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 12/5/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class AboutDivvyViewController: UIViewController {

    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //IBACTION
    @IBAction func aboutClicked(sender: UIButton) {
        performSegue(withIdentifier: "webAbout", sender: self)
    }
    
    @IBAction func priceClicked(sender: UIButton) {
        performSegue(withIdentifier: "webPrice", sender: self)
    }
    
    // this function will get called before the control is handed over to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webAbout" {// if destination id is webAbout
            let vc = segue.destination as! WebViewController
            vc.urlString = "https://www.divvybikes.com/how-it-works"
            vc.navigationItem.title = "HOW IT WORKS"
        }
        else if segue.identifier == "webPrice" {// if destination id is webPrice
            let vc = segue.destination as! WebViewController
            vc.urlString = "https://www.divvybikes.com/pricing"
            vc.navigationItem.title = "PRICING"
        }
    }

}
