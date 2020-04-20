//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Amanpreet Singh on 20/04/20.
//  Copyright © 2020 Amanpreet Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let notificationTrigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func customNotificationBtnClicked(_ sender:UIButton) {
         scheduleLocalNotification()
     }
    
    @IBAction func videoNotificationBtnClicked(_ sender:UIButton) {
            scheduleVideoNotification()
    }
    
    func scheduleLocalNotification(){
           let notificationCenter = UNUserNotificationCenter.current()
           let content = UNMutableNotificationContent()
           content.title = "ABC News"
           content.subtitle = "EU to unveil virus exit plan, hoping to avoid more chaos "
           let openAction = UNNotificationAction(identifier: "open", title: "Open News", options: [])
           let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: [])
           let category = UNNotificationCategory(identifier: "category", actions: [openAction,declineAction], intentIdentifiers: [], options: [])
           notificationCenter.setNotificationCategories([category])
           content.categoryIdentifier = "category"
           content.sound = .default
           if let path = Bundle.main.path(forResource: "logo", ofType: "png"){
                  let url = URL(fileURLWithPath: path)
                  do{
                      let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                      content.attachments = [attachment]
                  }
                  catch{
                      print("The attachment was not loaded.")
                  }
           }
           content.userInfo = ["url":"https://abcnews.go.com/Health/wireStory/eu-unveil-virus-exit-plan-hoping-avoid-chaos-70157413","imageUrl":"https://s.abcnews.com/images/Health/WireAP_3678978c4e1049b596e28e037734b623_16x9_992.jpg"]
           let notificationRequest = UNNotificationRequest(identifier: "notification", content: content, trigger: notificationTrigger)
           notificationCenter.add(notificationRequest) { (error) in
               if error == nil{
                   print("notification scheduled")
               }
           }
       }
       
       func scheduleVideoNotification(){
           let notificationCenter = UNUserNotificationCenter.current()
                  let notificationContent = UNMutableNotificationContent()
                  notificationContent.title = "Get bored of Lockdown ? 🤔"
                  notificationContent.subtitle = "Watch this video to refresh your mood"
                  let openAction = UNNotificationAction(identifier: "Like", title: "Liked it 👍", options: [])
                  let declineAction = UNNotificationAction(identifier: "Close", title: "Close", options: [])
                  let category = UNNotificationCategory(identifier: "videoNotificationCategory", actions: [openAction,declineAction], intentIdentifiers: [], options: [])
                  notificationCenter.setNotificationCategories([category])
                  notificationContent.categoryIdentifier = "videoNotificationCategory"
                  notificationContent.sound = .default
                  if let path = Bundle.main.path(forResource: "logo", ofType: "png"){
                         let url = URL(fileURLWithPath: path)
                         do{
                             let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                             notificationContent.attachments = [attachment]
                         }
                         catch{
                             print("The attachment was not loaded.")
                         }
                  }
                  notificationContent.userInfo = ["videoUrl":"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4"]
                  
                  let notificationRequest = UNNotificationRequest(identifier: "notification", content: notificationContent, trigger: notificationTrigger)
                  notificationCenter.add(notificationRequest) { (error) in
                      if error == nil{
                          print("notification scheduled")
                      }
                  }
       }
}
