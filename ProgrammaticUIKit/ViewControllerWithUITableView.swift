//
//  ViewControllerWithUITableView.swift
//  ProgrammaticUIKit
//
//  Created by Gio Peña on 1/9/23.
//

import UIKit

/*
 An example of a plain UIViewController that is extended to have UITableView functionality.
 */

class ViewControllerWithUITableView: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        return tableView
    }()
    var safeArea = UILayoutGuide()
    var data: [String] = ["a", "b", "c"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }

    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(ViewControllerWithUITableView.self)")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func setupViewController() {
        self.title = "\(ViewControllerWithUITableView.self)"
        view.backgroundColor = .systemGroupedBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.2.fill"),
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(trailingButtonAction))
    }
    
    
    @objc func trailingButtonAction() {
        print("tbd...")
    }

}








//MARK: -
extension ViewControllerWithUITableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ViewControllerWithUITableView.self)", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}
