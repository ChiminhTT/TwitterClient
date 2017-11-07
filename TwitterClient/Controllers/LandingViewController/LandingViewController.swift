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
  
}

// MARK: - Fetch Model Functions
extension LandingViewController
{

  func fetchOAuthAccessToken()
  {
    requestOAuthAccessToken { resp in
      switch resp
      {
      case .Ok(let accessToken):
        self.model.accessToken = accessToken
        self.performSegue(withIdentifier: "initSegue", sender: nil)
      case .Err(_):
        self.displayNetworkErrorAlert()
      }
    }
  }
  
  func displayNetworkErrorAlert()
  {
    DispatchQueue.main.async
    {
      self.present(
        buildAlertNetworkError(actionLabel: "Retry",
                               actionHandler: self.fetchOAuthAccessToken),
        animated: true
      )
    }
  }
  
}

// MARK: - Navigation
extension LandingViewController
{
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    guard let accessToken = self.model.accessToken else { return }

    let tweetTableViewModel =
      TweetTableViewModel(accessToken: accessToken, tweets: [])
    
    let navVC = segue.destination as? UINavigationController
    let tweetTableVC = navVC?.viewControllers.first as! TweetTableViewController
    tweetTableVC.model = tweetTableViewModel
  }

}

