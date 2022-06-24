//
//  UIView+RecursiveSubview.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/20/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func tp_descendants<ViewClass: UIView>(of targetClass: ViewClass.Type) -> [ViewClass] {
        var result = [ViewClass]()
        
        for subview in subviews {
            if let targetSubview = subview as? ViewClass {
                result.append(targetSubview)
            }
            
            result.append(contentsOf: subview.tp_descendants(of: targetClass))
        }
        
        return result
    }
    
}
