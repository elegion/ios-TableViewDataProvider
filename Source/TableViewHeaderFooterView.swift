//
//  TableViewHeaderFooterView.swift
//  Pods-Example
//
//  Created by Ilya Kulebyakin on 10/20/17.
//

import UIKit

open class TableViewHeaderFooterView: UITableViewHeaderFooterView {

    open class var estimatedHeight: CGFloat {
        return height ?? 44.0
    }
    
    open class var height: CGFloat? {
        return nil
    }

}
