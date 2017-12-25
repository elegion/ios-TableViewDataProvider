//
//  TableViewDataProvider+Reloading.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func reloadData() {
        guard isTableOwner else { return }
        
        tableView.reloadData()
    }
    
    public func reloadSections(with identifiers: Identifiable..., animation: UITableViewRowAnimation = .automatic) throws {
        let indices = try identifiers.map(self.indexForSection)
        
        reloadSections(IndexSet(indices: indices), animation: animation)
    }
    
    public func reloadSection(with descriptors: SectionDescriptor..., animation: UITableViewRowAnimation = .automatic) throws {
        let indices = try descriptors.map(self.indexForSection)
        
        reloadSections(IndexSet(indices: indices), animation: animation)
    }
    
    public func reloadSections(_ sections: IndexSet, animation: UITableViewRowAnimation = .automatic) {
        guard isTableOwner else { return }
        
        tableView.reloadSections(sections, with: .automatic)
    }
    
    public func reloadRows(with identifiers: Identifiable..., animation: UITableViewRowAnimation = .automatic) throws {
        let indexPaths = try identifiers.map(self.indexPathForRow)
        
        reloadRows(at: indexPaths, animation: animation)
    }
    
    public func reloadRows(with descriptors: CellDescriptor..., animation: UITableViewRowAnimation = .automatic) throws {
        let indexPaths = try descriptors.map(self.indexPathForRow)
        
        reloadRows(at: indexPaths, animation: animation)
    }
    
    public func reloadRows(at paths: [IndexPath], animation: UITableViewRowAnimation = .automatic) {
        guard isTableOwner else { return }
        
        tableView.reloadRows(at: paths, with: animation)
    }
    
}
