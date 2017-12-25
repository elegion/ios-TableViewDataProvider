//
//  TableViewDataProvider+SectionIdentifiction.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 12/22/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func indexForSection(with identifier: Identifiable) -> Int? {
        return sectionIndex {
            (_, section) -> Bool in
            
            return section.identifier?.isEqual(to: identifier) ?? false
        }
    }
    
    public func sectionDescriptor(with identifier: Identifiable) -> SectionDescriptor? {
        guard let index = indexForSection(with: identifier) else {
            return nil
        }
        
        return sections[index]
    }
    
    internal func indexForSection(with descriptor: SectionDescriptor) ->Int? {
        return sectionIndex {
            (_, section) -> Bool in
            
            return section === descriptor
        }
    }
    
    private func sectionIndex(where predicate: (Int, SectionDescriptor) -> Bool) -> Int? {
        return sections.enumerated().first(where: predicate)?.offset
    }
    
}
