//
//  ImageApi.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import Alamofire
import UIKit

let imageApi = ImageApi()
let apiKey = "7b85e389607020e3b5a12c5a40e260db"
let apiURL = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(apiKey)"

class ImageApi: ImageApiProtocol {
    
    private func generateApiUrl(page: Int) -> String {
        let url = apiURL + "&page=\(page)" + "&format=json&nojsoncallback=1"
        return url
    }
    
    private func get(
        page: Int,
        completionHandler: @escaping (DataResponse<Any>) -> Void
        ) {
        Alamofire.request(
            generateApiUrl(page: page),
            method: .get,
            encoding: URLEncoding.default
            ).responseJSON(completionHandler: completionHandler)
    }
    
    func getImages(page: Int, completion: @escaping ((Alamofire.Result<Any>)->Void)) {
        
        get(page: page) { response in
            switch response.response?.statusCode {
            case .some(200):
                completion(response.result)
                
            default:
                completion(response.result)
            }
        }
    }
}
