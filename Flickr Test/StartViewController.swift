//
//  StartViewController.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import UIKit
import PureLayout

class StartViewController: BaseUIViewController {
    
    private let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = NSLocalizedString("Flickr Test", comment: "Labels")
        testLabel.font = UIFont.systemFont(ofSize: 40)
        testLabel.textColor = UIColor.blue
        
        view.addSubview(testLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func setupConstraints() {
        testLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        testLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
