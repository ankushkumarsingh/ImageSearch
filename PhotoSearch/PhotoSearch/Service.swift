//
//  Service.swift
//  PhotoSearch
//
//  Created by Ankush Singh on 04/05/19.
//  Copyright © 2019 Ankush Singh. All rights reserved.
//
import Foundation
import UIKit

class Service: NSObject {
  static let shared = Service()
  
  func flickrURLFromParameters(searchString: String,page:Int = 1) -> URL {
    let pageString = String(page)
    // Build base URL
    var components = URLComponents()
    components.scheme = Constants.FlickrURLParams.APIScheme
    components.host = Constants.FlickrURLParams.APIHost
    components.path = Constants.FlickrURLParams.APIPath
    
    // Build query string
    components.queryItems = [URLQueryItem]()
    
    // Query components
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.APIKey, value: Constants.FlickrAPIValues.APIKey))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SearchMethod, value: Constants.FlickrAPIValues.SearchMethod))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.ResponseFormat, value: Constants.FlickrAPIValues.ResponseFormat))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Extras, value: Constants.FlickrAPIValues.MediumURL))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SafeSearch, value: Constants.FlickrAPIValues.SafeSearch))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.DisableJSONCallback, value: Constants.FlickrAPIValues.DisableJSONCallback))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Page, value: pageString))
    components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Text, value: searchString))
    
    return components.url!
  }
  
  func performFlickrSearch(_ searchURL: URL, completion: @escaping (ImageModal?, String?,Error?) -> ()) {
    
    // Perform the request
    let session = URLSession.shared
    let request = URLRequest(url: searchURL)
    let task = session.dataTask(with: request){
      (data, response, error) in
      if (error == nil)
      {
        // Check response code
        let status = (response as! HTTPURLResponse).statusCode
        if (status != 200 || status == 300)
        {
          completion(nil,"Server returned an error",nil)
          return;
        }
        
        /* Check data returned? */
        guard let data = data else {
          completion(nil,"No data was returned by the request!",nil)
          return
        }
        
        do {
          let images = try JSONDecoder().decode(ImageModal.self, from: data)
          DispatchQueue.main.async {
            completion(images,nil, nil)
          }
        } catch let jsonErr {
          completion(nil,"Failed to decode:",jsonErr)
        }
        
      }
      else{
        completion(nil,(error?.localizedDescription),error)
      }
    }
    task.resume()
  }

}
