//
//  DataModel.swift
//  日程表
//
//  Created by 张环宇 on 2022/9/23.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
    }
    
    // MARK: - Data Saving
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("ReservedChecklists.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }
    
}
