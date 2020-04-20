//
//  NotificationViewController.swift
//  CustomNotification
//
//  Created by Amanpreet Singh on 20/04/20.
//  Copyright © 2020 Amanpreet Singh. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

        @IBOutlet var notificationTitle: UILabel!
        @IBOutlet var notificationSubTitle: UILabel!
        @IBOutlet var imageView: UIImageView!
        @IBOutlet var activityIndicator: UIActivityIndicatorView!

        override func viewDidLoad() {
            super.viewDidLoad()
            self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
            activityIndicator.startAnimating()
        }
        
        func didReceive(_ notification: UNNotification) {
            let content = notification.request.content
            self.notificationTitle.text = content.title
            self.notificationSubTitle.text = content.subtitle
            if let imageUrl = content.userInfo["imageUrl"] as? String, let url = URL(string: imageUrl){
                    if let image = try? UIImage(data: Data(contentsOf: url)){
                        self.imageView.image = image
                        self.activityIndicator.stopAnimating()
                }
           }
        }
        
        func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
                if response.actionIdentifier == "decline"{
                    DispatchQueue.main.async {
                        completion(.dismiss)
                    }
                }
                else {
                    completion(.dismissAndForwardAction)
            }
        }
}
