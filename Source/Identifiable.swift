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
