//
//  TableViewDataProvider+UITableViewDataSource.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 12/25/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

extension TableViewDataProvider: UITableViewDataSource {
    
    private func registerCellIfNeeded(from descriptor: CellDescriptor, in tableView: UITableView) {
        guard !registeredCellIdentifiers.contains(descriptor.reuseIdentifier) else {
            return
        }
        
        registeredCellIdentifiers.insert(descriptor.reuseIdentifier)
        tableView.tp_register(cellType: descriptor.cellClass)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentSection = sections[section]
        
        return currentSection.rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let descriptor = section.rows[indexPath.row]
        
        guard descriptor.isVisible, section.isVisiblie  else {
            return emptyCellFor(indexPath: indexPath, in: tableView)
        }
        
        registerCellIfNeeded(from: descriptor, in: tableView)
        
        let cell = tableView.tp_dequeueCell(of: descriptor.cellClass, for: indexPath)
        
        descriptor.configuration(cell)
        
        return cell
    }
    
    private func emptyCellFor(indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Consts.emptyCellIdentifier, for: indexPath)
        cell.isHidden = true
        return cell
    }
    
}
