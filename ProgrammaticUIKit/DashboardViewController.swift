//
//  DashboardViewController.swift
//  ProgrammaticUIKit
//
//  Created by Gio Peña on 1/9/23.
//

import UIKit

class DashboardViewController: UITableViewController {
    var tableSections: [SettingsTableSection] = [
        SettingsTableSection(title: "Server Settings", cells: [SettingsTableSection.CellData(type: .button, label: "Foo"),
                                                               SettingsTableSection.CellData(type: .button, label: "bar")
                                                              ])
//    SettingsTableSection(title: "FTP", cells: <#T##[SettingsTableSection.SettingsTableCellData]#>),
//    SettingsTableSection(title: "Printer", cells: <#T##[SettingsTableSection.SettingsTableCellData]#>),
//    SettingsTableSection(title: "btn-refreshSettings", cells: <#T##[SettingsTableSection.SettingsTableCellData]#>),
//    SettingsTableSection(title: "Btn-TouchID", cells: <#T##[SettingsTableSection.SettingsTableCellData]#>)
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
    }
    
    
    struct SettingsTableSection {
        var title: String
        var cells: [CellData]
        
        init(title: String, cells: [CellData]) {
            self.title = title
            self.cells = cells
        }
        
        
        
        struct CellData {
            var type: CellType
            var label: String
//            var placeholder: String
            enum CellType {
                case button, navigationbutton, textField
            }
            
            init(type: CellType, label: String) {
                self.type = type
                self.label = label
            }
        }
    }
    
    
    

    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(DashboardViewController.self)")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = 44
    }
    
    
    private func setupViewController() {
        self.title = "\(DashboardViewController.self)"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.2.fill"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(trailingButtonAction))
    }
    
    
    @objc func trailingButtonAction() {
        print("tbd...")
    }

}








//MARK: - UITableView
extension DashboardViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DashboardViewController.self)", for: indexPath)
        cell.textLabel?.text = tableSections[indexPath.section].cells[indexPath.row].label
        return cell
    }
    
}
