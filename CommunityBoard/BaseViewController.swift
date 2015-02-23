//
//  ViewController.swift
//  CommunityBoard
//
//  Created by David LoBosco on 2/11/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit

class BaseViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // let
        self.navigationBar.barTintColor = UIColor(red: 211.0/255, green: 70.0/255, blue: 74.0/255, alpha: 1);
        self.navigationBar.tintColor = UIColor(red: 159.0/255, green: 209.0/255, blue: 225.0/255, alpha: 1);
        self.title = "CommunityBoard";
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

