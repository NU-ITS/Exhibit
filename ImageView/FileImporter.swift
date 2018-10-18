//
//  JSONImporter.swift
//  ImageView
//
//  Created by Quentin Harouff on 10/11/18.
//  Copyright © 2018 Quentin Harouff. All rights reserved.
//

import Foundation

public class FileImporter {
    
    public static let shared = FileImporter()
    
    public func importJSON(jsonUrlString: String) {
        
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }

            do {
                playerData = try JSONDecoder().decode(PlayerData.self, from: data)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
        
    }
    
    
    public func importCSV(csvUrlString: String){
        
        if let url = URL(string: csvUrlString) {
            do {
                try playerData = csv(data: String(contentsOf: url))
            } catch {
                print("Cannot load contents")
            }
        } else {
            print("String was not a URL")
        }
        
    }
    
    
    func csv(data: String) -> PlayerData {
        var imageData: [ImageObject] = []
        var rows = data.components(separatedBy: "\r\n")
        rows.remove(at: 0)
        for row in rows {
            if (row != ""){
                let columns = row.components(separatedBy: ",")
                
                let name = columns[0]
                let url = columns[1]
                let duration = columns[2]
                let startOn = columns[4]
                let endBy = columns[5]
                
                imageData.append(ImageObject.init(name: name, url: url, duration: duration, startOn: startOn, endBy: endBy))
            }
        }
        let result: PlayerData = PlayerData.init(images: imageData)
        return result
    }
    
    
}
