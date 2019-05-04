//
//  PhotoCollectionViewCell.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

  @IBOutlet var imageView: UIImageView!
  
  var imageViewMoal : ImageViewModal! {
    didSet {
      imageView.image = nil
      imageView.setImageView(imageViewMoal)
//      if let url = imageViewMoal.imageUrl {
//        imageView.downloaded(from: url)
//      }
    }
  }

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
