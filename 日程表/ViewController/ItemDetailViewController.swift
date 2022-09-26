//
//  ItemDetailViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/13.
//

import UIKit
import UserNotifications

// protocol的定义，类似于其他语言的interface
// 可以继承
protocol ItemDetailViewControllerDelegate: AnyObject {
    func itemDetailViewControllerDidCancel(
        _ controller: ItemDetailViewController)
    func itemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishAdding item: ChecklistItem)
    func itemDetailViewController(
        _ controller: ItemDetailViewController,
        didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: ItemDetailViewControllerDelegate? // 委派器
    
    var itemToEdit: ChecklistItem?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    @IBAction func done() {
        // 与右上角的“确定”绑定
        if let item = itemToEdit {
            // 如果是编辑页面
            
            item.text = textField.text!
            
            // 同步页面状态
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueData = datePicker.date
            
            item.scheduleNotification()
            
            // 委托
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            // 如果是添加页面
            // 与键盘的“Done”绑定
            let item = ChecklistItem()
            item.text = textField.text!
            
            // 同步页面状态
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueData = datePicker.date
            
            item.scheduleNotification()
            
            // 委托
            delegate?.itemDetailViewController(self, didFinishAdding: item)
            
        }
    }
    @IBAction func shouldRemindToggled(_ switchControl: UISwitch) {
        textField.resignFirstResponder()
        
        if switchControl.isOn {
            
            // Notification autherization
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) {
                _, _ in
                // do nothing
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
            // 同步显示时间
            shouldRemindSwitch.isOn = item.shouldRemind
            datePicker.date = item.dueData
        }

    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // 在view controller渲染之前，这个函数会被调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 相当于 focus
        textField.becomeFirstResponder()
    }
    
    // MARK: - Txet Fild Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
}
