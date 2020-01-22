//
//  Notifire.swift
//  RSSDemo
//
//  Created by MohammadReza Jalilvand on 1/18/20.
//  Copyright © 2020 MohammadReza Jalilvand. All rights reserved.
//

import LNRSimpleNotifications

enum NotificationType {
    case error
    case success
}

class Notifire {
    
    private static var sharedNotifireManager: LNRNotificationManager = {
        let notificationManager = LNRNotificationManager()
        
        notificationManager.notificationsPosition = .top
        notificationManager.notificationsTitleTextColor = .white
        notificationManager.notificationsBodyTextColor = .white
        notificationManager.notificationsSeperatorColor = .gray
        
        return notificationManager
    }()
    
    class func shared() -> LNRNotificationManager{
        return sharedNotifireManager
    }
}

extension LNRNotificationManager {
    func showMessage(message: String, type: NotificationType){
        
        var title = ""
        
        switch type {
        case .error:
            self.notificationsBackgroundColor = .red
            title = Message.error.rawValue
        case .success:
            self.notificationsBackgroundColor = .blue
            title = Message.success.rawValue
        }
        
        self.showNotification(notification: LNRNotification(title: title, body: message, duration: LNRNotificationDuration.default.rawValue))
    }
}

