//
//  TableViewDataProvider.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/3/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public class TableViewDataProvider: NSObject {
    
    private enum Consts {
        static let emptyCellIdentifier = "com.e-legion.TableViewDataProvider.EmptyCell"
    }
    
    let tableView: UITableView
    let customHeaderFooters: Bool
    
    public init(tableView: UITableView, customHeaders: Bool) {
        self.tableView = tableView
        self.customHeaderFooters = customHeaders
        
        super.init()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Consts.emptyCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    public var sections: [SectionDescriptor] = []
    
    func cellDescriptor(for indexPath: IndexPath) -> CellDescriptor {
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    var numberOfCells: Int {
        return sections.reduce(into: 0, { $0 += $1.visibleRows.count })
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
            
            return sectionIdentifier.isEqual(to: identifier)
        }
    }
    
    public func indexOfSection(with identifier: Identifiable) -> Int? {
        let index = sections.index {
            (sec) -> Bool in
            
            guard let sectionIdentifier = sec.identifier else { return false }
            return sectionIdentifier.stringRepresentation == identifier.stringRepresentation
        }
        return index
    }
    
}

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
        
        return currentSection.rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let descriptor = section.rows[indexPath.row]
        
        guard descriptor.isVisible, section.isVisiblie  else {
            return emptyCellFor(indexPath: indexPath, in: tableView)
        }
        
        registerCellIfNeeded(from: descriptor)
        
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
