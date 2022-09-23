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
    init(name: String) {
        self.name = name
        super.init()
    }
    
    override init() {
        super.init()
    }
}
