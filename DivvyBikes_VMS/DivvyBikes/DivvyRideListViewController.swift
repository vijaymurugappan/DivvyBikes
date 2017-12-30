//
//  DivvyRideListViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 11/28/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class DivvyRideListViewController: UIViewController {
    
    //IBOUTLETS
    @IBOutlet weak var subTextView: UITextView!
    @IBOutlet weak var imageLarge: UIImageView!
    @IBOutlet weak var longTextView: UITextView!
    
    //VARIABLES
    var subText = String()
    var longText = String()
    var image = UIImage()
    
    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews() // update screen
        // Do any additional setup after loading the view.
    }
    
    func updateViews() { // updating the screen
        subTextView.text = subText
        imageLarge.image = image
        longTextView.text = longText
    }
    
}
