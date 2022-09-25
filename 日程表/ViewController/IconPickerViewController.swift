//
//  IconPickerViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/25.
//

import UIKit

protocol IconPickerViewControllerDelegate: AnyObject {
    func iconPicker(
        _picker: IconPickerViewController,
        didPick iconName: String
    )
}

class IconPickerViewController: UITableViewController {
    weak var delegate: IconPickerViewControllerDelegate?
    
    let icons = [
        "No Icon", "Appointments", "Birthdays", "Chores",
          "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"
    ]
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        // 得到当前图标名称
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 委派给父级视图
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(_picker: self, didPick: iconName)
        }
    }
}
