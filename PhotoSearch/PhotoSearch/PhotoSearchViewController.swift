//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//

import UIKit
let imageCollectionReuseIdentifier = "PhotoCollectionViewCell"
let myPaginationUpperLimit = 1000
class PhotoSearchViewController: UIViewController {

  @IBOutlet var searchTextField: UITextField!
  @IBOutlet var collectionView: UICollectionView!
  
  @IBOutlet var searchButton: UIButton!
  
  var pageCount = 1
  var currentSearchText = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpUI()
    // Do any additional setup after loading the view.
  }
  
  var imageURLArray = [ImageViewModal]()
  
  private func setUpUI(){
    let photoNib = UINib(nibName: imageCollectionReuseIdentifier, bundle: nil)
    collectionView.register(photoNib, forCellWithReuseIdentifier: imageCollectionReuseIdentifier)
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    
    self.searchTextField.delegate = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(searchTextFieldText), name: UITextField.textDidChangeNotification, object: nil)
  }
  
  func displayAlert(_ message: String)
  {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func searchButtonAction(_ sender: UIButton) {
    guard let searchText = searchTextField.text else {return}
    if (searchText.isEmpty)
    {
      displayAlert("Search text cannot be empty")
      return
    }
    self.search(searchText)
  }
  
  @objc func searchTextFieldText(){
    guard let searchText = searchTextField.text else {return}
    self.search(searchText)
  }
  
  private func search(_ searchText : String,_ page : Int = 1){
    if self.currentSearchText != searchText {
      self.clearData()
    }
    self.currentSearchText = searchText
    let searchURL = Service.shared.flickrURLFromParameters(searchString: searchText)
    print("URL: \(searchURL)")
    
    // Send the request
    Service.shared.performFlickrSearch(searchURL, completion: {(imageModal: ImageModal?,errorString: String?,error : Error?) in
      if let imgModal = imageModal {
        let photoArr = imgModal.photos.photo
        let array = photoArr.map({ (photo) -> ImageViewModal in
          return ImageViewModal(photo: photo)
        })
        
        self.imageURLArray += array
        self.collectionView.reloadData()
        
      }
    })
  }
  
  func clearData(){
    self.imageURLArray = []
    self.collectionView.reloadData()
  }
  
  func paginateMore(){
    pageCount += 1
    guard let searchText = self.searchTextField.text else {return}
    self.search(searchText,pageCount)
  }
  
}

extension PhotoSearchViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.imageURLArray.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    let imgModal = self.imageURLArray[indexPath.item]
    cell.imageViewMoal = imgModal
    return cell
  }
  
}

extension PhotoSearchViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
    if indexPath.item + 1 == self.imageURLArray.count && self.imageURLArray.count < myPaginationUpperLimit {
      self.paginateMore()
    }
  }
}
extension PhotoSearchViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return PhotoConstant.imageCellSize()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return PhotoConstant.collectionViewLineSpacing()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return PhotoConstant.collectionViewItemSpacing()
  }
}


extension PhotoSearchViewController : UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField){
    guard let searchText = textField.text else {return}
    if (searchText.isEmpty)
    {
      displayAlert("Search text cannot be empty")
      return;
    }
    self.search(searchText)
  }

}
