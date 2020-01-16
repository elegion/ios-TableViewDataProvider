//
//  CellDescriptor.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public class CellDescriptor {
    
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configuration: (UITableViewCell) -> Void
    let selection: ((UITableViewCell) -> Void)?
    let editingActions: ((IndexPath) -> [UITableViewRowAction]?)?
    let height: CGFloat?
    let estimatedHeight: CGFloat
    
    public var identifier: Identifiable?
    public var isVisible = true
    
    public init<Cell: TableViewCell>(configuration: @escaping (Cell) -> Void,
                              selection: ((Cell) -> Void)? = nil,
                              editingActions: ((IndexPath) -> [UITableViewRowAction]?)? = nil,
                              estimatedHeight: CGFloat = Cell.estimatedHeight,
                              height: CGFloat? = Cell.height,
                              reuseIdentifier: String = String(describing: type(of: Cell.self))) {
        
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        
        self.height = height
        self.estimatedHeight = estimatedHeight
        
        self.selection = selection.map({
            (selection) -> (UITableViewCell) -> Void in
            
            return  {
                cell in
                
                //swiftlint:disable force_cast
                selection(cell as! Cell)
                //swiftlint:enable force_cast
            }
        })
        
        self.editingActions = editingActions
        
        self.configuration = {
            cell in
            
            //swiftlint:disable force_cast
            configuration(cell as! Cell)
            //swiftlint:enable force_cast
        }
    }
    
}
