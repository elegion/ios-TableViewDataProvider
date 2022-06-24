//
//  TableViewDataProvider+ChangingData.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation
import UIKit

extension TableViewDataProvider {
    
    // TODO: Use batch updates
    public func updateCells(_ updates: [(cell: CellDescriptor, indexPath: IndexPath)], animation: UITableView.RowAnimation = .automatic) {
        for update in updates {
            sections[update.indexPath.section].rows[update.indexPath.row] = update.cell
        }
        
        withTableViewIfAccessible {
            $0.reloadRows(at: updates.map { $0.indexPath }, with: animation)
        }
    }
    
    public func updateCell(descriptor: CellDescriptor, at indexPath: IndexPath, animation: UITableView.RowAnimation = .automatic) {
        updateCells([(descriptor, indexPath)])
    }
    
    public func setRows(_ descriptors: [CellDescriptor], inSectionWithIdentifier identifier: Identifiable, animation: UITableView.RowAnimation = .automatic) throws {
        let index = try indexForSection(with: identifier)
            
        setRows(descriptors, toSectionAt: index, animation: animation)
        
    }
    
    public func setRows(_ descriptors: [CellDescriptor], to section: SectionDescriptor, animation: UITableView.RowAnimation = .automatic) throws {
        let index = try indexForSection(with: section)
        
        setRows(descriptors, toSectionAt: index)
    }
    
    public func setRows(_ descriptors: [CellDescriptor], toSectionAt index: Int, animation: UITableView.RowAnimation = .automatic) {
        sections[index].rows = descriptors
        
        withTableViewIfAccessible {
             $0.reloadSections(IndexSet(integer: index), with: animation)
        }
    }
    
    public func deleteAllRowsFromSectionWithIdentifier(_ identifier: Identifiable, animation: UITableView.RowAnimation = .automatic) throws {
        try setRows([], inSectionWithIdentifier: identifier, animation: animation)
    }
    
    public func deleteAllRowsFromSection(at index: Int, animation: UITableView.RowAnimation = .automatic) {
        setRows([], toSectionAt: index, animation: animation)
    }
    
    public func deleteAllRows(from section: SectionDescriptor, animation: UITableView.RowAnimation = .automatic) throws {
        try setRows([], to: section, animation: animation)
    }
    
}
