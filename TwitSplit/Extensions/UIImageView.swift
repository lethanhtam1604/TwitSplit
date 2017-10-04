//
//  UIImageView.swift
//  TwitSplit
//
//  Created by Thanh Tam Le on 10/4/17.
//  Copyright © 2017 Thanh Tam Le. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    // Mark: - Download & show image from url and cache
    func loadImagesUsingUrlString(urlString: String) {
        let url = URL(string: urlString)
        
        image = nil
        
        // Mark: Exist Image Cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        if let newURL = url {
            // Mark: Background Thread
            URLSession.shared.dataTask(with: newURL) { (data, _, error) in
                
                if error != nil {
                    print(error ?? "")
                    return
                }
                
                // Mark: Main Thread
                DispatchQueue.main.async {
                    if let newData = data {
                        if let imageToCache = UIImage(data: newData) {
                            imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                            self.image = imageToCache
                        }
                    }
                }
                }.resume()
        }
    }
}
