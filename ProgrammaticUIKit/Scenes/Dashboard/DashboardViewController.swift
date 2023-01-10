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
        tableView.register(DashboardTableCellTextField.self, forCellReuseIdentifier: "\(DashboardTableCellTextField.self)")
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
        return tableSections[section].cells.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: SettingsTableSection.CellData = tableSections[indexPath.section].cells[indexPath.row]
                
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellTextField.self)",
                                                    for: indexPath) as? DashboardTableCellTextField {
            //cell.accessoryType = .none
            cell.textField.delegate = self
            cell.textField.placeholder = cellData.label
            cell.textField.tag = 4
            cell.tag = 3
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellTextField.self)", for: indexPath)
            cell.accessoryType = .none
            let textField: UITextField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(textField)
            textField.delegate = self
            textField.tag = 11
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.topAnchor),
                textField.leadingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.leadingAnchor),
                textField.centerYAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.centerYAnchor),
                textField.trailingAnchor.constraint(equalTo: cell.contentView.layoutMarginsGuide.trailingAnchor)
            ])
            return cell
        }
    }
    
    
}


extension DashboardViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    
}

