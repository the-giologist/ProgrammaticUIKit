//
//  PickerDatabase.swift
//  ProgrammaticUIKit
//
//  Created by Gio Peña on 1/10/23.
//

import UIKit

class PickerDatabase: UITableViewController {
    
    private var databases: [ServerDatabase] = [
        ServerDatabase(label: "key", isSelected: false, tag: 1),
        ServerDatabase(label: "stone", isSelected: false, tag: "two"),
        ServerDatabase(label: "corona", isSelected: false, tag: true)
    ]
    var selectedDatabase: ServerDatabase? = nil
    private var selectedIndex: IndexPath? = nil
    
    //Create custom init to pass in values?
//    init(selectedDatabase: ServerDatabase? = nil, selectedIndex: IndexPath? = nil) {
//        self.selectedDatabase = selectedDatabase
//        self.selectedIndex = selectedIndex
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.refreshControl = UIRefreshControl()
        //tableView.refreshControl?.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(PickerDatabase.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        tableView.refreshControl?.beginRefreshing()
    }
    
    
    
    
}



//MARK: - UITableview
extension PickerDatabase {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        databases.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = databases[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PickerDatabase.self)", for: indexPath)
        cell.textLabel?.text = cellData.label
        cell.accessoryType = cellData.isSelected ? .checkmark : .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var indexPaths: [IndexPath] = []
        let cellData = databases[indexPath.row]
                        
        if let prevPath = selectedIndex {
            databases[prevPath.row].isSelected = false
            indexPaths.append(prevPath)
        }
        selectedIndex = indexPath
        selectedDatabase = cellData
        indexPaths.append(indexPath)
        databases[indexPath.row].isSelected = cellData.isSelected ? false : true
        tableView.reloadRows(at: indexPaths, with: .none)
    }
    
}


//MARK: - ServerDatabase
extension PickerDatabase {
    
    struct ServerDatabase { //May need to make Class in order to capture .isSelected changes.
        var label: String
        var isSelected: Bool
        var tag: Any
        
        init(label: String, isSelected: Bool, tag: Any) {
            self.label = label
            self.isSelected = isSelected
            self.tag = tag
        }
    }
    
}
