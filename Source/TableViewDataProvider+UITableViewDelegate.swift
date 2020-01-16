//
//  TableViewDataProvider+UITableViewDelegate.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 12/25/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

extension TableViewDataProvider: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        let descriptor = section.rows[indexPath.row]
        
        guard descriptor.isVisible && section.isVisiblie else {
            return 0.0
        }
        
        return descriptor.height ?? descriptor.estimatedHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        let descriptor = section.rows[indexPath.row]
        
        guard descriptor.isVisible && section.isVisiblie else {
            return 0.0
        }
        
        return descriptor.height ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let descriptor = sections[indexPath.section].rows[indexPath.row]
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        descriptor.selection?(cell)
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let descriptor = sections[indexPath.section].rows[indexPath.row]
        
        if descriptor.selection == nil {
            return nil
        }
        
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let descriptor = sections[indexPath.section].rows[indexPath.row]
        return descriptor.editingActions
    }
    
}
