//
//  PhotoConstant.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//

import Foundation
import UIKit

struct PhotoConstant {
  static func imageCellSize()-> CGSize{
    return CGSize(width: 200, height: 200)
  }
  
  static func collectionViewItemSpacing()->CGFloat {
    return CGFloat(2)
  }
  
  static func collectionViewLineSpacing()->CGFloat {
    return CGFloat(2)
  }
}

struct Constants {
  
  struct FlickrURLParams {
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
    static let APIPath = "/services/rest"
  }
  
  struct FlickrAPIKeys {
    static let SearchMethod = "method"
    static let APIKey = "api_key"
    static let Extras = "extras"
    static let ResponseFormat = "format"
    static let DisableJSONCallback = "nojsoncallback"
    static let SafeSearch = "safe_search"
    static let Text = "text"
    static let Page = "page"
  }
  
  struct FlickrAPIValues {
    static let SearchMethod = "flickr.photos.search"
    static let APIKey = "aef692d08d3f8970492dba56d0fe3b13"
    static let ResponseFormat = "json"
    static let DisableJSONCallback = "1"
    static let MediumURL = "url_m"
    static let SafeSearch = "1"
  }
  
}


//45cfc25e08e1df6b    secret

