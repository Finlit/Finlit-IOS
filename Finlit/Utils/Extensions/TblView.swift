//
//  TblView.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 28/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import Foundation

extension UITableView {
    
    func setEmptyMessage(_ message: String,tablename:UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tablename.bounds.size.width, height: tablename.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func restoreWithNoSeparator() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
