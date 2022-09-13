//
//  AddItemViewController.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/13.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    // MARK: - Actions
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

    }
    
}
