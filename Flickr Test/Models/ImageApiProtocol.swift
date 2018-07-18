//
//  ImageApiProtocol.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//
import Alamofire

protocol ImageApiProtocol {
    func getImages(page: Int, completion: @escaping ((Alamofire.Result<Any>)->Void))
}
