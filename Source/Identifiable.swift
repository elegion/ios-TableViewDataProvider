//
//  Identifiable.swift
//  TableViewDataProvider
//
//  Created by Sergey Bendak on 11/21/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public protocol Identifiable {
    
    var stringRepresentation: String { get }
    
}

extension String: Identifiable {
    
    public var stringRepresentation: String {
        return self
    }
    
}

extension Int: Identifiable {
    
    public var stringRepresentation: String {
        return String(self)
    }
    
}

extension Float: Identifiable {
    
    public var stringRepresentation: String {
        return String(self)
    }
    
}
