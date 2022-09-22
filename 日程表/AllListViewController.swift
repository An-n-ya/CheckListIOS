//
//  AllListViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/22.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    
    let cellIentifier = "ChecklistCell"
    var lists = [Checklist]()
    // or var lists = Array<Checklist>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 大号标题
        navigationController?.navigationBar.prefersLargeTitles = true
        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIentifier)
        
        
        // 假数据
        var list = Checklist()
        list.name = "工作"
        lists.append(list)
        list = Checklist()
        list.name = "学习"
        lists.append(list)
        list = Checklist(name: "日常")
        lists.append(list)
        list = Checklist(name: "TO DO")
        lists.append(list)
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIentifier, for: indexPath)
        
        // 更新cell信息
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! ChecklistViewController
            // 把checklist传递给 ChecklistViewController
            // 这里的as是转型的意思
            controller.checklist = sender as? Checklist
        } else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }

    // MARK: - Delegate
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // segue切换手动挡
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        
        let checklist = lists[indexPath.row]
        controller.checklistToEdit = checklist
        
        // 入navigation栈
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
