//
//  AddItemViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/13.
//

import UIKit

// protocol的定义，类似于其他语言的interface
// 可以继承
protocol AddItemViewControllerDelegate: AnyObject {
    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController)
    func addItemViewController(
        _ controller: AddItemViewController,
        didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: AddItemViewControllerDelegate? // 委派器
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    @IBAction func done() {
        // 与右上角的“确定”绑定
        // 与键盘的“Done”绑定
        let item = ChecklistItem()
        item.text = textField.text!
        delegate?.addItemViewController(self, didFinishAdding: item)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

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
