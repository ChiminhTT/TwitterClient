//
//  ViewController.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController
{
  
  // MARK: - Instance variables
  var model = LandingViewModel()

  // MARK: - Controller Life cycle
  override func viewDidLoad()
  {
    super.viewDidLoad()
    self.fetchOAuthAccessToken()
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Helper functions
  func fetchOAuthAccessToken()
  {
    requestOAuthAccessToken { (optAccessToken, optError) in
      guard optError == nil else
      {
        self.displayNetworkErrorAlert()
        return
      }
      
      if let accessToken = optAccessToken
      {
        self.model.accessToken = OAuthAccessToken(value: accessToken)
        self.performSegue(withIdentifier: "testSegue", sender: nil)
      }
    }
  }
  
  func displayNetworkErrorAlert()
  {
    DispatchQueue.main.async
    {
        self.present(
          buildAlertNetworkError(retryHandler: self.fetchOAuthAccessToken),
          animated: true
        )
    }
  }
  
}

