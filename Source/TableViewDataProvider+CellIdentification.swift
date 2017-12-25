//
//  TableViewDataProvider+CellIdentification.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 12/22/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func indexPathForRow(with identifier: Identifiable) throws -> IndexPath {
        let indexPath = cellIndexPath {
            (_, cell, _) -> Bool in
            
            return cell.identifier?.isEqual(to: identifier) ?? false
        }
        
        guard let result = indexPath else {
            throw Error.cellWithIdentifierNotFound(identifier)
        }
        
        return result
    }
    
    public func cellDescriptor(with identifier: Identifiable) throws -> CellDescriptor? {
        let indexPath = try indexPathForRow(with: identifier)
        
        return sections[indexPath.section].rows[indexPath.row]
    }
    
    internal func indexPathForRow(with descriptor: CellDescriptor) throws -> IndexPath {
        let indexPath = cellIndexPath {
            (_, cell, _) -> Bool in
            
            return cell === descriptor
        }
        
        guard let result = indexPath else {
            throw Error.cellDescriptorIsNotAssignedToProvicer(descriptor)
        }
        
        return result
    }
    
    private func cellIndexPath(where predicate: (SectionDescriptor, CellDescriptor, IndexPath) -> Bool) -> IndexPath? {
        for section in sections.enumerated() {
            for row in section.element.rows.enumerated() {
                let indexPath = IndexPath(row: row.offset, section: section.offset)
                if predicate(section.element, row.element, indexPath) {
                    return indexPath
                }
            }
        }
        
        return nil
    }
    
}
