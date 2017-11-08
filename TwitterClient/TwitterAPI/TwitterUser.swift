//
//  TwitterUser.swift
//  TwitterClient
//
//  Created by maxence on 08/11/2017.
//  Copyright © 2017 maxence_ho. All rights reserved.
//

import UIKit
import SwiftyJSON

struct TwitterUser: Encodable, Decodable
{
  let authorName: String
  let screenName: String
  let profileBannerURL: URL?
  let profileImageURL : URL?
}

extension TwitterUser
{
  init(from json: JSON)
  {
    self.authorName =
      json["name"].stringValue
    self.screenName =
      json["screen_name"].stringValue
    self.profileBannerURL =
      URL(string: json["profile_banner_url"].stringValue)
    self.profileImageURL =
      URL(string: json["profile_image_url_https"].stringValue)
  }
}
