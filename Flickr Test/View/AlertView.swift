//
//  AlertView.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(errMsg: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alert = UIAlertController(
            title: errMsg,
            message: nil,
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: NSLocalizedString("OK", comment: "Common"), style: .default, handler: handler)
        )
        present(alert, animated: true, completion: nil)
    }
}
