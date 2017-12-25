//
//  TableViewDataProvider+Visibility.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 12/22/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func setSection(at sectionIndex: Int, visible: Bool, animation: UITableViewRowAnimation = .automatic) {
        let section = sections[sectionIndex]
        
        guard section.isVisiblie != visible else {
            return
        }
        
        section.isVisiblie = visible
        
        withTableViewIfAccessible {
            $0.reloadSections(IndexSet(integer: sectionIndex), with: animation)
        }
    }
    
    public func setSection(with identifier: Identifiable, visible: Bool, animation: UITableViewRowAnimation = .automatic) throws {
        let index = try indexForSection(with: identifier)
        
        setSection(at: index, visible: visible, animation: animation)
    }
    
    public func setSection(with sectionDescriptor: SectionDescriptor, visible: Bool, animation: UITableViewRowAnimation = .automatic) throws {
        let index = try indexForSection(with: sectionDescriptor)
        
        setSection(at: index, visible: visible, animation: animation)
    }
    
    public func setRow(at indexPath: IndexPath, visible: Bool, animation: UITableViewRowAnimation = .automatic) {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        
        guard row.isVisible != visible else {
            return
        }
        
        row.isVisible = visible
        
        guard section.isVisiblie else {
            return
        }
        
        withTableViewIfAccessible {
            $0.reloadRows(at: [indexPath], with: animation)
        }
    }
    
    public func setRow(with identifier: Identifiable, visible: Bool, animation: UITableViewRowAnimation = .automatic) throws {
        let indexPath = try indexPathForRow(with: identifier)
            
        setRow(at: indexPath, visible: visible, animation: animation)
    }
    
    public func setRow(for descriptor: CellDescriptor, visible: Bool, animation: UITableViewRowAnimation = .automatic) throws {
        let indexPath = try indexPathForRow(with: descriptor)
        
        setRow(at: indexPath, visible: visible, animation: animation)
    }
    
}
