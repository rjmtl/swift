//
//  demo.swift
//  dummy
//
//  Created by Deepak on 24/10/23.
//  Copyright © 2023 Leonardo da Silva Menezes. All rights reserved.
//

import Foundation
import SnowplowTracker

class TrackerManager{
    static var tracker:TrackerController? = Snowplow.createTracker(namespace: "gt-swift", endpoint: "https://orga.proemsportsanalytics.com") {
        TrackerConfiguration()
         .appId("gt-ios")
            .base64Encoding(false)
            .sessionContext(true)
            .platformContext(true)
            .lifecycleAutotracking(true)
            .screenViewAutotracking(true)
            .screenContext(true)
            .applicationContext(true)
            .exceptionAutotracking(true)
            .installAutotracking(true)
            .userAnonymisation(false)
        SessionConfiguration(
            foregroundTimeout: Measurement(value: 30, unit: .minutes),
            backgroundTimeout: Measurement(value: 30, unit: .minutes)
        )
      }
    
    static func notificationReceivedEvernt(){
        let data = ["psa_ma_id":  "", "psa_campaign_id": "", "user_id":  Preference.userId]
        let event = SelfDescribing(schema: "iglu:com.proemsportsanalytics/login/notification_received/1-0-0", payload: data)
        TrackerManager.tracker?.track(event)
    }
    static func notificationOpenedEvernt(){
        let data = ["psa_ma_id":  "", "psa_campaign_id": "", "user_id":  Preference.userId]
        let event = SelfDescribing(schema: "iglu:com.proemsportsanalytics/login/notification_opened/1-0-0", payload: data)
        self.tracker?.track(event)
    }
    
    static func updateFcm(){
        let event = SelfDescribing(schema: "iglu:com.proemsportsanalytics/update_fcm_token/jsonschema/1-0-0", payload:[ "fcm_token": Preference.fcmToken ] )
        TrackerManager.tracker?.track(event)
    }
    static func loginEvent(){
        let data1 = ["user_id": Preference.userId  ];
        let event = SelfDescribing(schema: "iglu:com.proemsportsanalytics/login/jsonschema/1-0-0", payload: data1)
         TrackerManager.tracker?.track(event)
    }
    static func logout(){
        let data = ["user_id": Preference.userId  ];
        let event = SelfDescribing(schema: "iglu:com.proemsportsanalytics/logout/jsonschema/1-0-0", payload: data)
        TrackerManager.tracker?.track(event)
    }
    static func userEvent(){
        let data = [
            "email": Preference.email,
            "firstName": "YOUR_FIRST_NAME",
            "lastName": "YOUR_LAST_NAME",
            "phone": "YOUR_PHONE",
            "gender": "YOUR_GENDER",
            "dob": "YOUR_DOB",
            "country": "YOUR_COUNTRY",
            "state": "YOUR_STATE",
            "city": "YOUR_CITY"
        ]
              
        let event = SelfDescribing(schema: "iglu:com.proemsportsanalytics/user_attributes/jsonschema/1-0-0", payload: data)
        TrackerManager.tracker?.track(event)
    }
}
