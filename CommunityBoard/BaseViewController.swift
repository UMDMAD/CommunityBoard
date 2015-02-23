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
        self.navigationBar.barTintColor = UIColor(red: 255.0/255, green: 106.0/255, blue: 0/255, alpha: 1);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

