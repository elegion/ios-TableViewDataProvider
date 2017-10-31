//
//  CellProvider.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/31/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public protocol CellProvider {
    
    associatedtype Context
    
    func cellDescriptor(with context: Context) -> CellDescriptor?
    
}

public protocol StableCellProvider: CellProvider {
    
    func cellDescriptor(with context: Context) -> CellDescriptor
    
}

public extension StableCellProvider {
    
    func cellDescriptor(with context: Context) -> CellDescriptor? {
        return cellDescriptor(with: context) as CellDescriptor
    }
    
}
