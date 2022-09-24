//
//  AllListViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/22.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    
    let cellIentifier = "ChecklistCell"
    var dataModel: DataModel!
    // or var lists = Array<Checklist>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 大号标题
        navigationController?.navigationBar.prefersLargeTitles = true
        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIentifier)
        
        
//        // 假数据
//        var list = Checklist()
//        list.name = "工作"
//        lists.append(list)
//        list = Checklist()
//        list.name = "学习"
//        lists.append(list)
//        list = Checklist(name: "日常")
//        lists.append(list)
//        list = Checklist(name: "TO DO")
//        lists.append(list)
//
//        for list in lists {
//            let item = ChecklistItem()
//            item.text = "Item for \(list.name)"
//            list.items.append(item)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIentifier, for: indexPath)
        
        // 更新cell信息
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 存入userDefaults 以便用户退出下次打开时依然停留这个页面
        UserDefaults.standard.set(
            indexPath.row,
            forKey: "ChecklistIndex"
        )
        let checklist = dataModel.lists[indexPath.row]
        dataModel.indexOfSelectedChecklist = indexPath.row
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
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = dataModel.lists.firstIndex(of: checklist) {
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
        
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        
        // 入navigation栈
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MRAK: - Navigation Controller Delegates
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self {
            // 如果即将渲染首页屏，将ChecklistIndex设置为-1
            dataModel.indexOfSelectedChecklist = -1
        }
    }
}
