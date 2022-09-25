//
//  Checklist.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/22.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    var iconName = "No Icon"
    init(name: String) {
        self.name = name
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
