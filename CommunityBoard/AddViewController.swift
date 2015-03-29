//
//  AddViewController.swift
//  CommunityBoard
//
//  Created by Kieran Raftery on 3/28/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit


class AddViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBAction func submitPressed(sender: AnyObject) {
        
        println(titleField.text)
        println(addressField.text)
        println(cityField.text)
        println(stateField.text)
        println(descriptionField.text)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}