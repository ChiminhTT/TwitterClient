//
//  MessageAlert.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit

fileprivate func buildSMSErrorAlert(alertMsg: String, actionTxt: String) -> UIAlertController
{
  let alert = UIAlertController(title: "Whoops...",
                                message: alertMsg,
                                preferredStyle: .alert)
  let action = UIAlertAction(title: actionTxt,
                             style: .default,
                             handler: nil)
  alert.addAction(action)
  return alert
}

func buildMsgNotAvailableErrorAlert() -> UIAlertController
{
  let alertMsg = "SMS services are not available. Please try again."
  return buildSMSErrorAlert(alertMsg: alertMsg, actionTxt: "Continue")
}

func buildMsgSentErrorAlert() -> UIAlertController
{
  let alertMsg =  "Could not send SMS. Please try again."
  return buildSMSErrorAlert(alertMsg: alertMsg, actionTxt: "Continue")
}

func buildMsgSentSuccessAlert() -> UIAlertController
{
  let alertMsg = "SMS was successfully sent."
  let alert = UIAlertController(title: "SMS Sent",
                                message: alertMsg,
                                preferredStyle: .alert)
  let action = UIAlertAction(title: "Continue",
                             style: .default,
                             handler: nil)
  alert.addAction(action)
  return alert
}
