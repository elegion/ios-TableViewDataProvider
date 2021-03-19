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

        if useExactEstimatedCellHeight {
            print("estimatedHeightForRowAt:")
            if let cell = cachedCell(of: descriptor.cellClass) as? TableViewCell {
                descriptor.configuration(cell)
                return cell.exactHeight(forEstimatedWidth: estimatedTableViewWidth)
            } else {
                return descriptor.height ?? descriptor.estimatedHeight
            }
        } else {
            return descriptor.height ?? descriptor.estimatedHeight
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        let descriptor = section.rows[indexPath.row]
        
        guard descriptor.isVisible && section.isVisiblie else {
            return 0.0
        }
            
        if useExactCellHeight,
           let cell = cachedCell(of: descriptor.cellClass) as? TableViewCell {
            descriptor.configuration(cell)
            return cell.exactHeight(forEstimatedWidth: estimatedTableViewWidth)
        } else {
            return descriptor.height ?? UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let descriptor = sections[indexPath.section].rows[indexPath.row]
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        descriptor.selection?(cell, indexPath)
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
        if let trailingSwipeActionsConfiguration = descriptor.trailingSwipeActionsConfiguration {
            let configuration = trailingSwipeActionsConfiguration(indexPath)
            return configuration?.actions.map { action in
                let style: UITableViewRowAction.Style
                switch action.style {
                case .normal:
                    style = .normal
                case .destructive:
                    style = .destructive
                }
                return UITableViewRowAction(style: style, title: action.title) { _, indexPath in
                    action.handler(action, { success in })
                }
            }
        } else  {
            // Nil value causes table view to display default UIKit swipe-to-delete action
            // So we return empty array to disable swipe-to-delete action completely.
            return []
        }
    }
    
    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let descriptor = cellDescriptor(for: indexPath)
        if let trailingSwipeActionsConfiguration = descriptor.trailingSwipeActionsConfiguration {
            guard let configuration = trailingSwipeActionsConfiguration(indexPath) else { return nil }
            let actions: [UIContextualAction] = configuration.actions.map { action in
                let style: UIContextualAction.Style
                switch action.style {
                case .normal:
                    style = .normal
                case .destructive:
                    style = .destructive
                }
                let result = UIContextualAction(style: style, title: action.title) { (_, _, completion) in
                    action.handler(action, completion)
                }
                result.image = action.image
                return result
            }
            let result = UISwipeActionsConfiguration(actions: actions)
            result.performsFirstActionWithFullSwipe = configuration.performsFirstActionWithFullSwipe
            return result
        } else {
            // Return nil if you want the table to display the default set of actions.
            return UISwipeActionsConfiguration(actions: [])
        }
    }
    
}
