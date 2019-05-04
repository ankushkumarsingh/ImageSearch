//
//  UIImageView+Util.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//

import Foundation
import UIKit

let cache = NSCache<NSString, UIImage>()

extension UIImageView {
  
  func getFromCache(_ key : String) -> UIImage?{
    if let image = cache.object(forKey: key as NSString) {
      return image
    }
    return nil
  }
  
  func setImage(_ image : UIImage, key: String){
    cache.setObject(image, forKey: key as NSString)
  }
  
  func downloaded(from url: URL,_ key : String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
        self.setImage(image, key: key)
      }
      }.resume()
  }
  
  func downloaded(from link: String,_ key : String ,contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    if let image = getFromCache(link) {
      DispatchQueue.main.async() {
        self.image = image
      }
    } else {
      guard let url = URL(string: link) else { return }
      downloaded(from: url,key ,contentMode: mode)
    }
  }
  
  func setImageView(_ modal:ImageViewModal){
    downloaded(from: modal.imageUrl, modal.id)
  }
}
