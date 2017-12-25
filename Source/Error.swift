//
//  Error.swift
//  TableViewDataProvider
//
//  Created by Arkady Smirnov on 11/24/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    
    case sectionIdentifierIsAbsent
    
    case sectionWithIdentifierNotFound(Identifiable)
    case cellWithIdentifierNotFound(Identifiable)
    
    case sectionDescriptorIsNotAssignedToProvider(SectionDescriptor)
    case cellDescriptorIsNotAssignedToProvicer(CellDescriptor)
    
}
