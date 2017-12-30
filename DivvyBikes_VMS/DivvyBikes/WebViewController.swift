//
//  WebViewController.swift
//  DivvyBikes
//
//  Created by Vijay Murugappan Subbiah on 11/26/17.
//  Copyright © 2017 z1807314. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    //OUTLETS
    @IBOutlet weak var webView: UIWebView!
    
    var urlString = String()
    
    //VIEW DID LOAD - Default view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //loading the request from the url provided
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data,response,error) in
            if error == nil {
                self.webView.loadRequest(request)
            }
            else {
                //Error
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }

}
