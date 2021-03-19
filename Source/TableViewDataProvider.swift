//
//  TableViewDataProvider.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/3/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public class TableViewDataProvider: NSObject {
    
    internal enum Consts {
        static let emptyCellIdentifier = "com.e-legion.TableViewDataProvider.EmptyCell"
    }
    
    private let tableView: UITableView
    let customHeaderFooters: Bool
    
    /// Calculate estimated cell height base on content size
    public var useExactEstimatedCellHeight: Bool = false
    /// Calculate cell height base on content size
    public var useExactCellHeight: Bool = false
    /// Estimated width of table view for cell height calculations
    public var estimatedTableViewWidth: CGFloat = UIScreen.main.bounds.width
    
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
    
    internal var cachedCells: [String: UITableViewCell] = [:]
    
    func withTableViewIfAccessible(do actions: (UITableView) -> Void) {
        if tableView.dataSource === self && tableView.delegate === self {
            actions(tableView)
        }
    }
    
}
