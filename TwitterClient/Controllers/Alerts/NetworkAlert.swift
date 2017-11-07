//
//  NetworkAlert.swift
//  TwitterClient
//
//  Created by maxence on 07/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

func buildAlertNetworkError(
  retryHandler: @escaping () -> ()
) -> UIAlertController
{
  let alertMsg =
    "There was an error accessing the Twitter API. Please try again."
  let alert = UIAlertController(title: "Whoops...",
                                message: alertMsg,
                                preferredStyle: .alert)
  let action = UIAlertAction(title: "Retry",
                             style: .default,
                             handler: {(alert: UIAlertAction!) in retryHandler()})
  alert.addAction(action)
  return alert
}
