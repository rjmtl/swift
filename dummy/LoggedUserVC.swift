//
//  ViewControllerLoggedUser.swift
//  dummy
//
//  Created by Leonardo da Silva Menezes on 10/07/20.
//  Copyright © 2020 Leonardo da Silva Menezes. All rights reserved.
//

import Foundation
import UIKit
import SnowplowTracker
import FirebaseMessaging

class LoggedUserVC: UIViewController  {
    
    @IBOutlet weak var labelUserName: UILabel!
    var message : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelUserName.text = "FCMToken = \(Preference.fcmToken)"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelDidGetTapped))

        labelUserName.isUserInteractionEnabled = true
        labelUserName.addGestureRecognizer(tapGesture)
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                Preference.fcmToken =  token
                TrackerManager.updateFcm()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TrackerManager.userEvent()
    }
    
    @objc
    func labelDidGetTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {
            return
        }
        UIPasteboard.general.string = label.text
    }
    @IBAction func logOutAction(_ sender: UIButton) {
        Preference.deleteAll()
        if let loggedVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            UIApplication.firstKeyWindowForConnectedScenes?.rootViewController = loggedVC
            UIApplication.firstKeyWindowForConnectedScenes?.makeKeyAndVisible()
        }
    }
}
