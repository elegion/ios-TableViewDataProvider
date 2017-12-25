//
//  TableViewDataProvider+SectionIdentifiction.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 12/22/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func indexForSection(with identifier: Identifiable) throws -> Int {
        let index = sectionIndex {
            (_, section) -> Bool in
            
            return section.identifier?.isEqual(to: identifier) ?? false
        }
        
        guard let result = index else {
            throw Error.sectionWithIdentifierNotFound(identifier)
        }
        
        return result
    }
    
    public func sectionDescriptor(with identifier: Identifiable) throws -> SectionDescriptor {
        let index = try indexForSection(with: identifier)
        
        return sections[index]
    }
    
    internal func indexForSection(with descriptor: SectionDescriptor) throws -> Int {
        let index = sectionIndex {
            (_, section) -> Bool in
            
            return section === descriptor
        }
        
        guard let result = index else {
            throw Error.sectionDescriptorIsNotAssignedToProvider(descriptor)
        }
        
        return result
    }
    
    private func sectionIndex(where predicate: (Int, SectionDescriptor) -> Bool) -> Int? {
        return sections.enumerated().first(where: predicate)?.offset
    }
    
}
