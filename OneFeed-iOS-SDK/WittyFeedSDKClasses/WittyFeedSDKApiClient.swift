//
//  WittyFeedSDKApiClient.swift
//  wittyfeed_ios_notification_api
//
//  Created by Sudama Dewda on 02/02/18.
//  Copyright © 2018 wittyfeed. All rights reserved.
//

import Foundation
import SwiftyJSON

public class WittyFeedSDKApiClient {
    
    let api_key: String!
    let app_id: String!
    let package_name: String!
    let fcm_token: String!
    var user_meta = ""
    var device_id = ""
    let vc: UIViewController!
    let SDK_Version = "1.0.0"
    
    public init(apikey: String, appid: String, fcmtoken: String, vc: UIViewController ){
        self.api_key = apikey
        self.app_id = appid
        self.package_name = Bundle.main.bundleIdentifier!
        self.fcm_token = fcmtoken
        self.vc = vc
        self.user_meta = get_user_meta(para_usermeta: [:])
    }
    
    public init(apikey: String, appid: String, fcmtoken: String, usermeta: [String:String], vc: UIViewController ){
        self.api_key = apikey
        self.app_id = appid
        self.package_name = Bundle.main.bundleIdentifier!
        self.fcm_token = fcmtoken
        self.vc = vc
        self.user_meta = get_user_meta(para_usermeta: usermeta)
    }
    
    func get_user_meta(para_usermeta: [String:String]) -> String {
        var user_meta: [String:String] = [:]
        
        user_meta["device_type"] = "iOS"
        
        user_meta["onefeed_sdk_version"] = SDK_Version
        
        device_id = UIDevice.current.identifierForVendor!.uuidString
        user_meta["device_id"] = device_id
        user_meta["ios_id"] = device_id
        
        user_meta["client_locale"] = NSLocale.current.identifier
        user_meta["client_locale_language"] = NSLocale.current.languageCode!
        
        if para_usermeta["client_gender"] != nil {
            user_meta["client_gender"] = para_usermeta["client_gender"]
        } else {
            user_meta["client_gender"] = "N"
        }
        
        if para_usermeta["client_interests"] != nil {
            user_meta["client_interests"] = para_usermeta["client_interests"]
        } else {
            user_meta["client_interests"] = ""
        }
        
        let json = JSON(user_meta)
        
        return json.rawString()!
    }
  
}
