//
//  DashboardTableCellTextField.swift
//  ProgrammaticUIKit
//
//  Created by Gio on 1/10/23.
//

import UIKit

class DashboardTableCellTextField: UITableViewCell {
    
    let label = UILabel()
    let textField: UITextField = {
       let textField = UITextField()
        textField.textColor = .secondaryLabel
        textField.backgroundColor = .red
        return textField
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //setup label
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),  //silences warning
            label.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            widthAnchor.constraint(greaterThanOrEqualToConstant: 1)
        ])
        
        //setup textField
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}






class DashboardTableCellButton: UITableViewCell {
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //setup UIButton
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //Added .topAnchor constraint to silence warning: "Detected a case where constraints ambiguously suggest a height of zero"
            label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor),
//            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
