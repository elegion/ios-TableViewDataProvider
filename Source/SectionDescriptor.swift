//
//  SectionDescriptor.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public class SectionDescriptor {
    
    public enum HeaderFooterDescriptor {
        case none
        case text(String)
        case configuration(TableViewHeaderFooterView.Type, (UIView) -> Void)
        
        public init<Header: TableViewHeaderFooterView>(configuration: @escaping (Header) -> Void) {
            self = .configuration(Header.self, {
                (header) in
                
                configuration(header as! Header)
            })
        }
        
        var reuseIdentifier: String? {
            switch self {
            case .configuration(let headerFoooterClass, _):
                return String(describing: headerFoooterClass)
            default:
                return nil
            }
        }
    }
    
    var header: HeaderFooterDescriptor
    var footer: HeaderFooterDescriptor
    
    var rows: [CellDescriptor]
    
    public var identifier: Identifiable?
    public internal(set) var isCollapsed: Bool = false
    
    public init(header: HeaderFooterDescriptor = .none, footer: HeaderFooterDescriptor = .none, rows: [CellDescriptor]) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
    
    public convenience init<Header: TableViewHeaderFooterView>(rows: [CellDescriptor] = [], headerConfiguration: @escaping (Header) -> Void, rowHeight: CGFloat? = nil) {
        self.init(rows: rows, headerConfiguration: headerConfiguration, footerConfiguration: nil)
    }
    
    public convenience init<Footer: TableViewHeaderFooterView>(rows: [CellDescriptor] = [], footerConfiguration: @escaping (Footer) -> Void, rowHeight: CGFloat? = nil) {
        self.init(rows: rows, headerConfiguration: nil, footerConfiguration: footerConfiguration)
    }
    
    public init<Header: TableViewHeaderFooterView, Footer: TableViewHeaderFooterView>(rows: [CellDescriptor] = [], headerConfiguration: ((Header) -> Void)?, footerConfiguration: ((Footer) -> Void)?) {
        
        self.rows = rows
        
        self.header = headerConfiguration.map({
            configuration in
        
            return HeaderFooterDescriptor.configuration(Header.self, {
                (view) in
                
                configuration(view as! Header)
            })
        }) ?? .none
        
        self.footer = footerConfiguration.map({
            configuration in
            
            return HeaderFooterDescriptor.configuration(Header.self, {
                (view) in
                
                configuration(view as! Footer)
            })
        }) ?? .none
    }
    
    public func expand() {
        isCollapsed = false
    }
    
    public func collapse() {
        isCollapsed = true
    }
    
}
