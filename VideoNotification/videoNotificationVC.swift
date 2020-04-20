//
//  NotificationViewController.swift
//  VideoNotification
//
//  Created by Amanpreet Singh on 20/04/20.
//  Copyright © 2020 Amanpreet Singh. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVFoundation

class videoNotificationVC: UIViewController, UNNotificationContentExtension {

      @IBOutlet weak var notificationTitle: UILabel!
      @IBOutlet weak var notificationSubTitle: UILabel!
      @IBOutlet weak var videoView: UIView!
      @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

      var player:AVPlayer!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
          self.activityIndicator.startAnimating()
      }
      
      func didReceive(_ notification: UNNotification) {
          let content = notification.request.content
          self.notificationTitle.text = content.title
          self.notificationSubTitle.text = content.subtitle

          if let url = content.userInfo["videoUrl"] as? String, let videoUrl = URL(string: url){
              player = AVPlayer(url: videoUrl)
              let playerLayer = AVPlayerLayer(player: player)
              playerLayer.frame = self.videoView.bounds
              playerLayer.videoGravity = .resizeAspect
              self.videoView.layer.addSublayer(playerLayer)
              player.play()
              player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
          }
      }
      
      override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
          if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
              if #available(iOS 10.0, *) {
                  let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
                  let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
                  if newStatus != oldStatus {
                     DispatchQueue.main.async {[weak self] in
                         if newStatus == .playing || newStatus == .paused {
                          self?.activityIndicator.stopAnimating()
                         } else {
                          self?.activityIndicator.startAnimating()
                         }
                     }
                  }
              } else {
                  self.activityIndicator.stopAnimating()
              }
          }
    }
}
