//
//  Identifiable.swift
//  TableViewDataProvider
//
//  Created by Sergey Bendak on 11/21/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public protocol Identifiable {
    
    var identifier: String { get }
    
}

extension Identifiable {
    
    public func isEqual(to other: Identifiable?) -> Bool {
        guard let otherIdentifier = other?.identifier else {
            return false
        }
        return self.identifier == otherIdentifier
    }
    
}

extension String: Identifiable {
    
    public var identifier: String {
        return self
    }
    
}

extension Int: Identifiable {
    
    public var identifier: String {
        return String(self)
    }
    
}

extension Float: Identifiable {
    
    public var identifier: String {
        return String(self)
    }
    
}
