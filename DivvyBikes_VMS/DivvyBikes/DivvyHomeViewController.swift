//
//  DivvyHomeViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 11/26/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class DivvyHomeViewController: UIViewController {
    
    @IBOutlet weak var locateBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var rideListBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let infoLightBtn = UIButton(type: .infoLight)
        infoLightBtn.tintColor = UIColor.black
        infoLightBtn.addTarget(self, action: #selector(navigateAction), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: infoLightBtn)
        self.navigationItem.rightBarButtonItem = barBtn
        setcustomButton(button: locateBtn)
        setcustomButton(button: joinBtn)
        setcustomButton(button: rideListBtn)
        // Do any additional setup after loading the view.
    }
    
    func setcustomButton(button: UIButton) {
        button.layer.cornerRadius = 8.0
    }

    func navigateAction() {
        performSegue(withIdentifier: "AUTHOR", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
