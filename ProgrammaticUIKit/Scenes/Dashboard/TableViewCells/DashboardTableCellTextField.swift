//
//  DashboardTableCellTextField.swift
//  ProgrammaticUIKit
//
//  Created by Gio on 1/10/23.
//

import UIKit

class DashboardTableCellTextField: UITableViewCell {
    
    let textField = UITextField()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //setup textField
        self.contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            textField.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
