//
//  DashboardViewController.swift
//  ProgrammaticUIKit
//
//  Created by Gio Peña on 1/9/23.
//

import UIKit

class DashboardViewController: UITableViewController {
    var tableSections: [TableSection] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        
        tableSections = [
            TableSection(title: "Server Settings!", cells: [
                TableSection.CellData(.textField, label: "Tap to edit", closure: { print("closure!") }),
                TableSection.CellData(.button, label: "Refresh Settings", closure: { self.trailingButtonAction() }) ]),
            TableSection(title: "FTP", cells: [
                TableSection.CellData(.textField, label: "Username"),
                TableSection.CellData(.textField, label: "Password") ]),
            TableSection(title: "Printer", cells: [
                TableSection.CellData(.textField, label: "Regular"),
                TableSection.CellData(.navigationbutton, label: "Barcode", closure: {  }) ]),
            TableSection(title: "btn-refreshSettings", cells: [
                TableSection.CellData(.button, label: "Refresh Settings", closure: {  }) ]),
            TableSection(title: "Btn-TouchID", cells: [
                TableSection.CellData(.button, label: "Setup Biometric Authentication", closure: {  }) ])
        ]
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
            var closure: (() -> ())
//            var placeholder: String
            
            enum CellType {
                case button, navigationbutton, textField
            }
            
            init(_ type: CellType, label: String, closure: @escaping (() -> ()) = {}) {
                self.type = type
                self.label = label
                self.closure = closure
            }
        }
    }
    
    
    

    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(DashboardTableCellTextField.self, forCellReuseIdentifier: "\(DashboardTableCellTextField.self)")
        tableView.register(DashboardTableCellButton.self, forCellReuseIdentifier: "\(DashboardTableCellButton.self)")
        tableView.dataSource = self
        tableView.delegate = self
        /*Added in order to silence warning: "Detected a case where constraints ambiguously suggest a height of zero"
         Warning comming from DashboardTableCellButton.label
         */
        tableView.rowHeight = 44
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSections[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSections[section].cells.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: TableSection.CellData = tableSections[indexPath.section].cells[indexPath.row]
                
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellTextField.self)",
                                                    for: indexPath) as? DashboardTableCellTextField, cellData.type == .textField  {
//            cell.accessoryType = .none
            cell.textField.delegate = self
            cell.textField.placeholder = cellData.label
            cell.textField.tag = indexPath.row
            cell.tag = indexPath.row
            cell.selectionStyle = .none     //Used in order to prevent textField cells from highlighting when tapped
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellButton.self)",
                                                           for: indexPath) as? DashboardTableCellButton, cellData.type == .button {
            cell.label.text = cellData.label
            return cell
            
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellTextField.self)", for: indexPath)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(indexPath)
        let cellData = tableSections[indexPath.section].cells[indexPath.row]
        cellData.closure()
    }
    
}





//MARK: - +UITextFieldDelegate
extension DashboardViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.tag)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
    
}





//MARK: - TableSection model
extension DashboardViewController {
    
    struct TableSection {
        var title: String
        var cells: [CellData]
        
        init(title: String, cells: [CellData]) {
            self.title = title
            self.cells = cells
        }
        
        
        
        struct CellData {
            var type: CellType
            var label: String
            var closure: (() -> ())
//            var placeholder: String
            
            enum CellType {
                case button, navigationbutton, textField
            }
            
            init(_ type: CellType, label: String, closure: @escaping (() -> ()) = {}) {
                self.type = type
                self.label = label
                self.closure = closure
            }
        }
    }
}
