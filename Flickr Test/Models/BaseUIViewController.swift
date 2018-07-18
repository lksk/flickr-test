//
//  BaseUIViewController.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    private var didSetupConstraints = false
    
    override func viewDidLoad() {
        view.setNeedsUpdateConstraints()
        view.backgroundColor = UIColor.white
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            setupConstraints()
        }
        super.updateViewConstraints()
    }
    
    func setupConstraints() {
        fatalError("setupConstraints has not been implemented")
    }
}
