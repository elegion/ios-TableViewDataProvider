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
    
    public func setRows(_ descriptors: [CellDescriptor], in section: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) {
        if let index = sections.enumerated().first(where:  { $1 === section })?.offset {
            setRows(descriptors, toSectionAt: index)
        }
    }
    
    public func setRows(_ descriptors: [CellDescriptor], toSectionAt index: Int, animation: UITableViewRowAnimation = .automatic) {
        sections[index].rows = descriptors
        
        guard isTableOwner else { return }
        
        tableView.beginUpdates()
        let indexes = descriptors.enumerated().map { IndexPath(row: $0.offset, section: index) }
        tableView.insertRows(at: indexes, with: animation)
        tableView.endUpdates()
    }
    
    public func deleteAllRowsFromSection(at index: Int, animation: UITableViewRowAnimation = .automatic) {
        sections[index].rows = []
        
        guard isTableOwner else { return }
        
        tableView.beginUpdates()
        let indexes = (0..<tableView.numberOfRows(inSection: index)).map { IndexPath(row: $0, section: index) }
        tableView.deleteRows(at: indexes, with: animation)
        tableView.endUpdates()
    }
    
    public func deleteAllRows(from section: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) {
        if let index = sections.enumerated().first(where:  { $1 === section })?.offset {
            deleteAllRowsFromSection(at: index, animation: animation)
        }
    }
    
}
