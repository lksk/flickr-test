//
//  ImageTableViewCell.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    let titleLbl = UILabel()
    let photoView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.selectionStyle = .none
        
        //Setup title label
        titleLbl.textColor = UIColor.black
        titleLbl.font = UIFont.systemFont(ofSize: 18)
        
        //Add Subviews
        addSubview(titleLbl)
        addSubview(photoView)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        photoView.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        photoView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        photoView.autoSetDimension(.height, toSize: 75)
        photoView.autoSetDimension(.width, toSize: 75)
        
        titleLbl.autoPinEdge(.left, to: .right, of: photoView, withOffset: 10)
        titleLbl.autoAlignAxis(.horizontal, toSameAxisOf: photoView)
        
    }
    
    func getImageUrl(farm: Int, server: String, id: String, secret: String) -> String {
        //Format url to fetch image
        let url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_s.jpg"
        return url
    }
    
    func updateUI(image: Image) {
        //Fetch image and title and update UI.
        let urlString = getImageUrl(farm: image.farm, server: image.server, id: image.id, secret: image.secret)
        let url = URL(string: urlString)
        photoView.kf.setImage(with: url)
        titleLbl.text = image.title
    }
}
