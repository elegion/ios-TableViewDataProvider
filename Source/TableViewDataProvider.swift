//
//  TableViewDataProvider.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/3/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public class TableViewDataProvider: NSObject {
    
    let tableView: UITableView
    let customHeaderFooters: Bool
    
    public init(tableView: UITableView, customHeaders: Bool) {
        self.tableView = tableView
        self.customHeaderFooters = customHeaders
        
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    public var sections: [SectionDescriptor] = []
    
    func cellDescriptor(for indexPath: IndexPath) -> CellDescriptor {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    var numberOfCells: Int {
        return sections.reduce(into: 0, { $0 += $1.isCollapsed ? 0 : $1.rows.count })
    }
    
    var registeredCellIdentifiers = Set<String>()
    var registeredHeaderFooterIdentifiers = Set<String>()
    
    var isTableOwner: Bool {
        return tableView.dataSource === self && tableView.delegate === self
    }
    
    public func sectionWithIdentifier(_ identifier: Identifiable) -> SectionDescriptor? {
        return sections.first {
            (sectionDescriptor) -> Bool in
            
            guard let sectionIdentifier = sectionDescriptor.identifier else { return false }
            
            return sectionIdentifier.stringRepresentation == identifier.stringRepresentation
        }
    }
    
}

extension TableViewDataProvider: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let descriptor = cellDescriptor(for: indexPath)
        
        return descriptor.height ?? descriptor.estimatedHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descriptor = cellDescriptor(for: indexPath)
        
        return descriptor.height ?? UITableViewAutomaticDimension
    }
    
}

extension TableViewDataProvider: UITableViewDataSource {
    
    private func registerCellIfNeeded(from descriptor: CellDescriptor) {
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
        return currentSection.isCollapsed ? 0 : currentSection.rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let descriptor = cellDescriptor(for: indexPath)
        registerCellIfNeeded(from: descriptor)
        
        let cell = tableView.tp_dequeueCell(of: descriptor.cellClass, for: indexPath)
        
        descriptor.configuration(cell)
        
        return cell
    }
    
}
