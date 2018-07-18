//
//  StoreData.swift
//  Flickr Test
//
//  Created by Lakshmikantha H on 7/17/18.
//  Copyright © 2018 Lakshmikantha H. All rights reserved.
//

import Foundation

class StoreData {
    let fileManager = FileManager()
    
    func saveData(data: [Image]) {
        
        // Url for documents directory
        let url = getDocumentsURL().appendingPathComponent("data.json")
        
        // Endcode data to JSON Data
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(data)
            
            // Check if file already exists
            if fileManager.fileExists(atPath: url.path) {
                
                //Remove if file exists
                try fileManager.removeItem(at: url)
            }
            // Create file with the data encoded
            fileManager.createFile(atPath: url.path, contents: jsonData, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getData() -> [Image]? {
        
        // Url for documents directory
        let url = getDocumentsURL().appendingPathComponent("data.json")
        
        // Check if exists
        if !fileManager.fileExists(atPath: url.path) {
            return nil
        }
        
        // Retrieve data
        if let jsonData = fileManager.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                // Decode data
                let data = try decoder.decode([Image].self, from: jsonData)
                return data
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func getDocumentsURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
}
