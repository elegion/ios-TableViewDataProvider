//
//  SectionProvider.swift
//  TableViewDataProvider
//
//  Created by Arkady Smirnov on 11/24/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public protocol SectionProvider {
    
    associatedtype SectionContext
    
    func sectionDescriptor(with context: SectionContext) -> SectionDescriptor?
    
}

public protocol StableSectionProvider: SectionProvider {
    
    func sectionDescriptor(with context: SectionContext) -> SectionDescriptor
    
}

public extension StableSectionProvider {
    
    func sectionDescriptor(with context: SectionContext) -> SectionDescriptor? {
        return sectionDescriptor(with: context) as SectionDescriptor
    }
    
}
