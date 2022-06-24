//
//  SeparatorView.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/20/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation
import UIKit

class SeparatorView: UIView {
    
}

extension UIView {
    
    func setSeparators(_ config: [(position: LinePosition, color: UIColor?, width: CGFloat)]) {
        tp_descendants(of: SeparatorView.self).forEach { $0.removeFromSuperview() }
        
        for separator in config {
            
            let separatorFrame: CGRect
            let separatorAutoresizingMask: UIView.AutoresizingMask
            
            switch separator.position {
            case .left(offsets: let offsets):
                separatorFrame = CGRect(x: 0,
                                        y: offsets.top,
                                        width: separator.width,
                                        height: bounds.height - offsets.top - offsets.bottom)
                separatorAutoresizingMask = [.flexibleRightMargin, .flexibleHeight]
            case .top(offsets: let offsets):
                separatorFrame = CGRect(x: offsets.left,
                                        y: 0.0,
                                        width: bounds.width - offsets.left - offsets.right,
                                        height: separator.width)
                separatorAutoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
            case .right(offsets: let offsets):
                separatorFrame = CGRect(x: bounds.width - separator.width,
                               y: offsets.top,
                               width: separator.width,
                               height: bounds.height - offsets.top - offsets.bottom)
                separatorAutoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
            case .bottom(offsets: let offsets):
                separatorFrame = CGRect(x: offsets.left,
                               y: bounds.height - separator.width,
                               width: bounds.width - offsets.left - offsets.right,
                               height: separator.width)
                separatorAutoresizingMask = [.flexibleTopMargin, .flexibleWidth]
            }
            
            let view = SeparatorView(frame: separatorFrame)
            view.backgroundColor = separator.color
            view.autoresizingMask = separatorAutoresizingMask
            
            addSubview(view)
        }
    }
    
}
