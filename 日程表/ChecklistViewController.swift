//
//  ViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/7.
//

import UIKit

class ChecklistViewContoller: UITableViewController, AddItemViewControllerDelegate {
    
    
    
    // MARK: - Variables
    var items = [ChecklistItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        
        let item0 = ChecklistItem()
        item0.text = "遛狗"
        items.append(item0)
        
        let item1 = ChecklistItem()
        item1.text = "刷牙"
        item1.checked = true
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "学习"
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "运动"
        item3.checked = true
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "吃冰激凌"
        items.append(item4)
    }
    
    // MARK: - Help Functions
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistitem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.checked.toggle()
            
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Add Item ViewController Delegates
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        // 在这里接受到AddItemViewController传递过来的item
        // 把item添加到items里去
        let newRowIndex = items.count
        items.append(item)
        
        tableView.insertRows(at: [IndexPath(row: newRowIndex, section: 0)], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            // 把当前controller传递给AddItemViewController
            controller.delegate = self
        }
    }


}

