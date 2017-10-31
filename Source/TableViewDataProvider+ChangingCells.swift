//
//  TableViewDataProvider+ChangingData.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func updateCells(_ updates: [(cell: CellDescriptor, indexPath: IndexPath)], animation: UITableViewRowAnimation = .automatic) {
        for update in updates {
            sections[update.indexPath.section].rows[update.indexPath.row] = update.cell
        }
        
        guard isTableOwner else { return }
     
        tableView.reloadRows(at: updates.map { $0.indexPath }, with: animation)
    }
    
    public func updateCell(descriptor: CellDescriptor, at indexPath: IndexPath, animation: UITableViewRowAnimation = .automatic) {
        updateCells([(descriptor, indexPath)])
    }
    
}
