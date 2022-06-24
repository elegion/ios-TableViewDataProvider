//
//  TableViewDataProvider+ScrollTo.swift
//  TableViewDataProvider
//
//  Created by Arkady Smirnov on 11/28/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation
import UIKit

extension TableViewDataProvider {
    
    public func scrollTo(section descriptor: SectionDescriptor, at scrollPosition: UITableView.ScrollPosition, animated: Bool) throws {
        let index = try indexForSection(with: descriptor)
        
        scrollToSection(at: index, at: scrollPosition, animated: animated)
    }
    
    public func scrollToSection(with identifier: Identifiable, at scrollPosition: UITableView.ScrollPosition, animated: Bool) throws {
        let index = try indexForSection(with: identifier)
        
        scrollToSection(at: index, at: scrollPosition, animated: animated)
    }
    
    public func scrollToSection(at index: Int, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        withTableViewIfAccessible {
            var row = 0
            var scrollToIndex = sections.enumerated().dropFirst(index).first(where: {
                return !$0.element.rows.isEmpty
            })?.offset
            
            if scrollToIndex == nil {
                scrollToIndex = sections.prefix(index).reversed().enumerated().first(where: {
                    (offset, element) -> Bool in
                    
                    return !element.rows.isEmpty
                })?.offset
                
                if let scrollToIndex = scrollToIndex {
                    row = sections[scrollToIndex].rows.count - 1
                }
            }
            
            guard let section = scrollToIndex else {
                return
            }
            
            $0.scrollToRow(at: IndexPath(row: row, section: section), at: scrollPosition, animated: animated)
        }
    }
    
}
