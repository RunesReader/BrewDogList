//
//  LoadImageService.swift
//  BrewDogList
//
//  Created by Ihor Arsenkin on 30.01.2020.
//  Copyright © 2020 Igor Arsenkin. All rights reserved.
//

import UIKit
import SDWebImage

struct LoadImageService {
    static func loadImage(with indicatorType: SDWebImageActivityIndicator, url: URL?, imageView: UIImageView?, completion: ((UIImage) -> Swift.Void)? = nil) {
        if url == nil { return }
        
        imageView?.sd_imageIndicator = indicatorType
        
        if let completion = completion {
            imageView?.sd_setImage(with: url) { (image, _, _, _) in
                completion(image ?? UIImage())
            }
        } else {
            imageView?.sd_setImage(with: url)
        }
    }
    
    static func loadImage(with indicatorType: SDWebImageActivityIndicator, urlString: String, imageView: UIImageView?, completion: ((UIImage) -> Swift.Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        LoadImageService.loadImage(with: indicatorType, url: url, imageView: imageView, completion: completion)
    }
}
