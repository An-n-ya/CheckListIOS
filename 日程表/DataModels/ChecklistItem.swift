//
//  ChecklistItem.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/12.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable{
    var text = ""
    var checked = false
    
    var dueData = Date()
    var shouldRemind = false
    var itemID = -1
    
    override init() {
        super.init()
        // 获取itemID
        itemID = DataModel.nextChecklistItemID()
    }
    
    // 当前实例被删除时，取消通知
    deinit {
        removeNotification()
    }
    
    // 设置通知
    func scheduleNotification() {
        // 去除之前的通知
        removeNotification()
        if !checked && shouldRemind && dueData > Date() {
            // 设置通知内容
            let content = UNMutableNotificationContent()
            content.title = "日程表通知："
            content.body = text
            content.sound = UNNotificationSound.default
            
            // 格式化时间
            let calender = Calendar(identifier: .gregorian)
            let components = calender.dateComponents([.year, .month, .day, .hour, .minute], from: dueData)
            
            // 设置同时时机
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            // 设置通知
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            // 挂载通知
            let center = UNUserNotificationCenter.current()
            center.add(request)
        }
    }
    
    // 取消通知
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    
}
