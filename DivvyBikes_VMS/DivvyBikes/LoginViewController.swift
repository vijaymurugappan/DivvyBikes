//
//  LoginViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 11/25/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var exploreBtn: UIButton!
    
    @IBAction func loginBtnClicked(sender: UIButton) {
        showAlert(Title: "LOGIN DISABLED", Desc: "This is just a prototype - click join or explore")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setcustomTextField(textfield: loginTextField, placeholdername: "MEMBER LOGIN")
        setcustomTextField(textfield: passTextField, placeholdername: "MEMBER PASSWORD")
        setcustomButton(button: loginBtn)
        setcustomButton(button: joinBtn)
        setcustomButton(button: exploreBtn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setcustomTextField(textfield: UITextField, placeholdername: String) {
        textfield.backgroundColor = UIColor.clear
        textfield.layer.borderWidth = 1.0
        textfield.layer.cornerRadius = 8.0
        textfield.layer.borderColor = UIColor.blue.cgColor
        textfield.attributedPlaceholder = NSAttributedString(string: placeholdername, attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func showAlert(Title: String, Desc: String) {
        let alertController = UIAlertController(title: Title, message: Desc, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) {
            (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setcustomButton(button: UIButton) {
        button.layer.cornerRadius = 8.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

