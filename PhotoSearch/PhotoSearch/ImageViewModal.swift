//
//  ImageViewModal.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//

import Foundation

struct ImageViewModal {
  var id : String
  var imageUrl : String
  
  init(photo : Photo) {
    self.id = photo.id
    self.imageUrl = photo.url_m
  }
  
}
