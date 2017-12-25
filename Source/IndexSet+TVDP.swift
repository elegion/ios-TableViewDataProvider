//
//  IndexSet+TVDP.swift
//  Pods-Example
//
//  Created by Ilya Kulebyakin on 12/25/17.
//

import Foundation

extension IndexSet {
    
    internal init(indices: [Int]) {
        var set = IndexSet()
        
        for index in indices {
            set.insert(index)
        }
        
        self = set
    }
    
}
