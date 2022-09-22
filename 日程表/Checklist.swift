//
//  Checklist.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/22.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    init(name: String) {
        self.name = name
        super.init()
    }
    
    override init() {
        super.init()
    }
}
