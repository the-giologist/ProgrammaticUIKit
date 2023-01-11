//
//  DashboardViewController.swift
//  ProgrammaticUIKit
//
//  Created by Gio Peña on 1/9/23.
//

import UIKit

class DashboardViewController: UITableViewController {
    var tableSections: [TableSection] = []
    
    var pickerDatabase = PickerDatabase()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        
        tableSections = [
            TableSection(title: "Server Settings!", cells: [
                TableSection.CellData(.textField, label: "Tap to edit"),
                TableSection.CellData(.button, label: "Database", accessoryType: .disclosureIndicator, closure: { self.navigationController?.pushViewController(self.pickerDatabase, animated: true) }) ]),
            TableSection(title: "FTP", cells: [
                TableSection.CellData(.textField, label: "Username"),
                TableSection.CellData(.textField, label: "Password") ]),
            TableSection(title: "Printer", cells: [
                TableSection.CellData(.textField, label: "Regular"),
                TableSection.CellData(.button, label: "Barcode", accessoryType: .disclosureIndicator, closure: {
                    self.showWarning() }) ]),
            TableSection(cells: [
                TableSection.CellData(.button, label: "Refresh Settings", closure: { self.showView() }) ]),
            TableSection(cells: [
                TableSection.CellData(.button, label: "Setup Biometric Authentication", closure: { self.showWarning() }) ])
        ]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.refreshControl?.beginRefreshing()
    }
    

    
    private func setupTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(trailingButtonAction), for: .valueChanged)
        
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(DashboardTableCellTextField.self, forCellReuseIdentifier: "\(DashboardTableCellTextField.self)")
        tableView.register(DashboardTableCellButton.self, forCellReuseIdentifier: "\(DashboardTableCellButton.self)")
        tableView.dataSource = self
        tableView.delegate = self
        /*Added in order to silence warning: "Detected a case where constraints ambiguously suggest a height of zero"
         Warning comming from DashboardTableCellButton.label
         */
//        tableView.rowHeight = 44
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
    
    
    private func showWarning() {
        print("showingWarning")
    }

    
    private func showView() {
        print("showingView")
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
            //cell.accessoryType = .none
            cell.tag = indexPath.row
            cell.label.text = cellData.label
            cell.textField.tag = indexPath.row
            cell.textField.delegate = self
            cell.textField.placeholder = cellData.label
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellButton.self)",
                                                           for: indexPath) as? DashboardTableCellButton, cellData.type == .button {
            cell.accessoryType = cellData.accessoryType
            cell.label.text = cellData.label
            return cell
            
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "\(DashboardTableCellTextField.self)", for: indexPath)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("didSelect: \(indexPath)")
        let cellData = tableSections[indexPath.section].cells[indexPath.row]
        
        if (cellData.type == .button) {
            if (cellData.accessoryType == .disclosureIndicator) {
                cellData.closure()
                
            } else {
                let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "actionTitle", style: .default, handler: { _ in
                    print("pressedAlertAction")
                }))
                alert.addAction(UIAlertAction(title: "destructiveTitle", style: .destructive, handler: { _ in
                    print("pressedAlertAction")
                }))
                alert.addAction(UIAlertAction(title: "cancelTitle", style: .cancel, handler: { _ in
                    print("pressedAlertAction")
                }))
                self.present(alert, animated: true)
            }
            
            
        } else if (cellData.type == .navigationbutton) {
            cellData.closure()
        }
        
        
        
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
        var title: String?
        var cells: [CellData]
        
        init(title: String? = nil, cells: [CellData]) {
            self.title = title
            self.cells = cells
        }
        
        
        
        struct CellData {
            var type: CellType
            var label: String
            var accessoryType: UITableViewCell.AccessoryType
            var closure: (() -> ())
//            var placeholder: String
            
            enum CellType {
                case button, navigationbutton, textField
            }
            
            init(_ type: CellType, label: String, accessoryType: UITableViewCell.AccessoryType = .none, closure: @escaping (() -> ()) = {}) {
                self.type = type
                self.label = label
                self.accessoryType = accessoryType
                self.closure = closure
            }
        }
    }
}
