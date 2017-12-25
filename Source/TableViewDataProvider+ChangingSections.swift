//
//  TableViewDataProvider+ChangingSections.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    // TODO: Batch updates + insert
    public func append(sections descriptiors: [SectionDescriptor], animation: UITableViewRowAnimation = .automatic) {
        sections.append(contentsOf: descriptiors)
        
        withTableViewIfAccessible {
            let insertedIndexSet = IndexSet(integersIn: (sections.count - descriptiors.count)..<sections.count)
            $0.insertSections(insertedIndexSet, with: animation)
        }
    }
    
    public func append(section descriptor: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) {
        append(sections: [descriptor], animation: .automatic)
    }
    
    public func insert(section descriptor: SectionDescriptor, at index: Int, animation: UITableViewRowAnimation = .automatic) {
        sections.insert(descriptor, at: index)
        
        withTableViewIfAccessible {
            $0.insertSections(IndexSet(integer: index), with: animation)
        }
    }
    
    public func replaceIdentifiedSection(_ section: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) throws {
        guard let identifier = section.identifier else {
            throw Error.sectionIdentifierIsAbsent
        }
        
        let index = try indexForSection(with: identifier)
        
        replaceSection(at: index, with: section, animation: animation)
    }

    public func replaceSection(at index: Int, with section: SectionDescriptor, animation: UITableViewRowAnimation = .automatic) {
        sections[index] = section
        
        withTableViewIfAccessible {
            $0.reloadSections(IndexSet(integer: index), with: animation)
        }
    }
    
    public func deleteSections(at indexes: IndexSet, animation: UITableViewRowAnimation = .automatic) {
        self.sections = sections
            .enumerated()
            .filter { !indexes.contains($0.offset) }
            .map { $0.element }
        
        withTableViewIfAccessible {
            $0.deleteSections(indexes, with: animation)
        }
    }
    
    public func deleteSection(at index: Int, animation: UITableViewRowAnimation = .automatic) {
        deleteSections(at: IndexSet(integer: index), animation: animation)
    }
    
}
