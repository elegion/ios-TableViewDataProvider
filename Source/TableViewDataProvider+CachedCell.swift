//
//  TableViewDataProvider+CellHeightCalculation.swift
//  TableViewDataProvider
//
//  Created by Марат Джаныбаев on 17.03.2021.
//

import Foundation

extension TableViewDataProvider {
        
    internal func cachedCell<T: UITableViewCell>(of cellType: T.Type) -> T {
        let name = String(describing: cellType)
        if let cachedCell = cachedCells[name] as? T {
            return cachedCell
        } else {
            let cell = initCell(of: cellType)
            cachedCells[name] = cell
            return cell
        }
    }
    
    private func initCell<T: UITableViewCell>(of cellType: T.Type) -> T {
        let name = String(describing: cellType)
        let bundle = Bundle(for: cellType)
        if bundle.path(forResource: name, ofType: "nib") != nil,
           let cell = bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return cell
        } else {
            return cellType.init()
        }
    }

}
