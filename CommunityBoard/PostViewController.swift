//
//  PostViewController.swift
//  CommunityBoard
//
//  Created by Kieran Raftery on 4/10/15.
//  Copyright (c) 2015 MAD. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var titleText = ""
    var addressText = ""
    var cityText = ""
    var stateText = ""
    var descriptionText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        addressLabel.text = addressText
        cityLabel.text = cityText
        stateLabel.text = stateText
        descriptionTextView.text = descriptionText
        
        descriptionTextView.font = UIFont.systemFontOfSize(17)
    }
}
