//
//  AppDelegate.swift
//  dummy
//
//  Created by Leonardo da Silva Menezes on 10/07/20.
//  Copyright © 2020 Leonardo da Silva Menezes. All rights reserved.
//

import UIKit
import SnowplowTracker
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        notificationPermission(application)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func notificationPermission( _ application: UIApplication){
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        
        
        UIApplication.shared.registerForRemoteNotifications()

        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        Preference.fcmToken =  fcmToken ?? ""
        TrackerManager.updateFcm()
              
        

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
      Messaging.messaging().apnsToken = deviceToken
        
    }

    // Notification Received

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("notification - ",userInfo)
        TrackerManager.notificationReceivedEvernt(data: userInfo)
    }
    
    // Notification Opened
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("response - ",userInfo)
        TrackerManager.notificationOpenedEvernt(data: userInfo)
    }
}

//[AnyHashable("psa_ma_id"): NA, AnyHashable("aps"): {
//    alert =     {
//        body = hello;
//        title = hi;
//    };
//}, AnyHashable("psa_campaign_id"): 77, AnyHashable("google.c.fid"): ckwr26R3mEG2gN3v8_POrY, AnyHashable("psa_event_id"): NA, AnyHashable("google.c.sender.id"): 223634938268, AnyHashable("google.c.a.e"): 1, AnyHashable("gcm.message_id"): 1706206585262274]
