//
//  TableViewDataProvider+ChangingSections.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func append(sections descriptiors: [SectionDescriptor], animation: UITableViewRowAnimation = .automatic) {
        sections.append(contentsOf: descriptiors)
        
        guard isTableOwner else { return }
        
        let insertedIndexSet = IndexSet(integersIn: (sections.count - descriptiors.count)..<sections.count)
        tableView.insertSections(insertedIndexSet, with: animation)
    }
    
    public func append(section descriptor: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) {
        append(sections: [descriptor], animation: .automatic)
    }
    
    public func insert(section descriptor: SectionDescriptor, at index: Int, animation: UITableViewRowAnimation = .automatic) {
        sections.insert(descriptor, at: index)
        
        guard isTableOwner else { return }
        
        tableView.insertSections(IndexSet(integer: index), with: animation)
    }
    
    public func replaceSection(at index: Int, withSection section: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) {
        sections[index] = section
        
        guard isTableOwner else {
            return
        }
        
        tableView.reloadSections(IndexSet(integer: index), with: animation)
    }
    
    public func deleteSections(at indexes: IndexSet, animation: UITableViewRowAnimation = .automatic) {
        self.sections = sections
            .enumerated()
            .filter { !indexes.contains($0.offset) }
            .map { $0.element }
        
        guard isTableOwner else { return }
        
        tableView.deleteSections(indexes, with: animation)
    }
    
    public func deleteSection(at index: Int, animation: UITableViewRowAnimation = .automatic) {
        deleteSections(at: IndexSet(integer: index), animation: animation)
    }
    
}
