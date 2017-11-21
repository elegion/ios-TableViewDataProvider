//
//  Identifiable.swift
//  TableViewDataProvider
//
//  Created by Sergey Bendak on 11/21/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

protocol Identifiable {
    
    var identifier: String { get }
    
}

extension String: Identifiable {
    
    var identifier: String {
        return self
    }
    
}

extension Int: Identifiable {
    
    var identifier: String {
        return String(self)
    }
    
}

extension Float: Identifiable {
    
    var identifier: String {
        return String(self)
    }
    
}
