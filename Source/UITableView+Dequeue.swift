//
//  UITableView+DataProvider.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/20/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension UINib {
    
    convenience init?(safeWithName name: String, bundle: Bundle = .main) {
        guard bundle.path(forResource: name, ofType: "nib") != nil else {
            return nil
        }
        
        self.init(nibName: name, bundle: bundle)
    }
    
}

extension UITableView {
    
    func tp_register<Cell: UITableViewCell>(cellType: Cell.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let reuseIdentifier = String(describing: cellType)
        
        if tryNib, let nib = UINib(safeWithName: reuseIdentifier, bundle: bundle) {
            register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func tp_dequeueCell<Cell: UITableViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
    
    func tp_register<HeaderFooter: UITableViewHeaderFooterView>(headerFooterType: HeaderFooter.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let identifier = String(describing: headerFooterType)
        
        if tryNib, let nib = UINib(safeWithName: identifier, bundle: bundle) {
            register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(headerFooterType, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    func tp_dequeueHeaderFooter<HeaderFooter: UITableViewHeaderFooterView>(of viewType: HeaderFooter.Type) -> HeaderFooter {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewType)) as! HeaderFooter
    }
    
}
