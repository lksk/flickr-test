//
//  ImagesTableViewController.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import UIKit
import PureLayout

class ImagesTableViewController: BaseUIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pageNumber = 1
    var service: ImageApiProtocol = ImageApi()
    var storage = StoreData()
    var imageListData = [Image]()
    
    private let imageCellId = "imageCell"
    private let imageList = UITableView()
    private let loadMoreButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup table view
        imageList.backgroundColor = UIColor.clear
        imageList.delegate = self
        imageList.dataSource = self
        imageList.rowHeight = 105
        imageList.register(ImageTableViewCell.self, forCellReuseIdentifier: imageCellId)
        imageList.separatorStyle = .singleLine
        imageList.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        imageList.separatorColor = UIColor.black
        imageList.tableFooterView = UIView()
        
        //Setup load more button
        loadMoreButton.setTitle(NSLocalizedString("Load More", comment: "Button"), for: .normal)
        loadMoreButton.setTitleColor(UIColor.blue, for: .normal)
        loadMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loadMoreButton.addTarget(self, action: #selector(loadMoreButtonClick), for: .touchUpInside)        
        loadMoreButton.isHidden = true
        
        //Setup activity indicator
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        //Add sub-views
        view.addSubview(imageList)
        view.addSubview(loadMoreButton)
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Fetch Data to display in the table view.
        if let imageListData = storage.getData() {
            self.imageListData = imageListData
            if self.imageListData.count == 0 {
                getList(page: pageNumber)
            }
        } else {
            getList(page: pageNumber)
        }
    }

    override func setupConstraints() {
        imageList.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        imageList.autoPin(toBottomLayoutGuideOf: self, withInset: 55)
        imageList.autoPinEdge(toSuperviewEdge: .left)
        imageList.autoPinEdge(toSuperviewEdge: .right)
        
        loadMoreButton.autoPinEdge(.top, to: .bottom, of: imageList, withOffset: 10)
        loadMoreButton.autoPinEdge(toSuperviewEdge: .left, withInset: 34)
        loadMoreButton.autoPinEdge(toSuperviewEdge: .right, withInset: 34)
        loadMoreButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        loadMoreButton.autoSetDimension(.height, toSize: 40)
        
        activityIndicator.autoAlignAxis(toSuperviewAxis: .vertical)
        activityIndicator.autoAlignAxis(toSuperviewAxis: .horizontal)

    }
    
    // MARK - TableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: imageCellId) as? ImageTableViewCell,
            imageListData.count > indexPath.row {
            
            let photo = imageListData[indexPath.row]
            activityIndicator.stopAnimating()
            cell.updateUI(image: photo)
            
            //Display Load more button at the end of the batch.
            if (indexPath.row == (imageListData.count)-1) {
                loadMoreButton.isHidden = false
            } else if (indexPath.row < (imageListData.count)-8){
                loadMoreButton.isHidden = true
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    // MARK - Helper Functions

    func getList(page: Int) {
        var images = [Image]()
        
        self.service.getImages(page: page) {result in
            //Dispaly error if notwork is unavailable
            if let e = result.error, (e as NSError).code == -1009 {
                self.showErrorAlert(errMsg: NSLocalizedString("No Network", comment: "Error Message"))
            }
            guard
                let resp = result.value as? [String: Any],
                let pageList: PageList = PageList(JSON: resp) else {
                    return
            }
            images = pageList.photos.photo
            self.imageListData.append(contentsOf: images)
            imagePersistanceData = self.imageListData
            //Disply data in the table view.
            DispatchQueue.main.async { self.imageList.reloadData()
            }
        }
    }
    
    
    @objc func loadMoreButtonClick() {
        //Load more button Action
        pageNumber = pageNumber + 1
        getList(page: pageNumber)
    }
}
