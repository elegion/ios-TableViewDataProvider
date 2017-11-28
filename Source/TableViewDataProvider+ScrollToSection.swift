//
//  TableViewDataProvider+ScrollTo.swift
//  TableViewDataProvider
//
//  Created by Arkady Smirnov on 11/28/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func scrollTo(sectionDescriptor: SectionDescriptor, at scrollPosition: UITableViewScrollPosition, animated animatedFlag: Bool ) throws {
        if let identifier = sectionDescriptor.identifier {
            try scrollToSection(with: identifier, at: scrollPosition, animated: animatedFlag)
        } else {
            throw Error.IdentifierIsEmpty
        }
    }
    
    public func scrollToSection(with identifier: Identifiable, at scrollPosition: UITableViewScrollPosition, animated animatedFlag: Bool  ) throws {
        
        if let index = indexOfSection(with: identifier) {
            guard isTableOwner else {
                return
            }
            let indexPath = IndexPath(row: 0, section: index)
            tableView.scrollToRow(at: indexPath, at: scrollPosition, animated: animatedFlag)
        } else {
            throw Error.SectionWithIdentifierNotFound(identifier)
        }
    }
    
}
