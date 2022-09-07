//
//  ViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/7.
//

import UIKit

class ChecklistViewContoller: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // TODO: 试试看
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistitem", for: indexPath)
        // FIXME: ddd
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            label.text = "遛狗"
        } else if indexPath.row == 1 {
            label.text = "刷牙"
        } else if indexPath.row == 2 {
            label.text = "学习"
        } else if indexPath.row == 3 {
            label.text = "锻炼"
        } else if indexPath.row == 4 {
            label.text = "吃冰激淋"
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}

