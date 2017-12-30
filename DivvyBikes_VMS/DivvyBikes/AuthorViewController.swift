//
//  AuthorViewController.swift
//  Divvy Bikes
//  This file loads the User Portfolio Page in a WebView
//  Created by Vijay Murugappan Subbiah on 11/27/17.
//  Copyright © 2017 Vijay Murugappan Subbiah. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var webView: UIWebView!
    
    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //Getting the url file and loading the request
        let url = Bundle.main.url(forResource: "index", withExtension: "html")
        let URLObj = URLRequest(url: url!)
        webView.loadRequest(URLObj);
    }
}
