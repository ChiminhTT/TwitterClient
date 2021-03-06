//
//  UIImageViewExtension.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit
extension UIImageView
{
  
  func loadImage(url: URL) -> URLSessionDownloadTask
  {
    let session = URLSession.shared
    let downloadTask = session.downloadTask(with: url,
                                            completionHandler:
      { [weak self] url, response, error in
        if error == nil,
          let url = url,
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data)
        {
          DispatchQueue.main.async
            {
              if let weakSelf = self
              {
                weakSelf.image = image
              }
          }
        }
    })
    downloadTask.resume()
    return downloadTask
  }
  
  func asCircle()
  {
    self.layer.borderWidth = 0.5
    self.layer.masksToBounds = false
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.cornerRadius = self.frame.height/2
    self.clipsToBounds = true
  }
  
}

