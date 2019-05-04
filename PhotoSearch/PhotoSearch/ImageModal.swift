//
//  ImageModal.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//

import Foundation

struct ImageModal : Decodable {
  var photos : Photos
  var stat : String
}

struct Photos : Decodable {
  var page : Int
  var pages : Int
  var perpage : Int
  var total : String
  var photo : [Photo]
}

struct Photo : Decodable {
  var id : String
  var url_m : String
}
