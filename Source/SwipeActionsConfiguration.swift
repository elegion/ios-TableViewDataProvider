//
//  SwipeActionsConfiguration.swift
//  TableViewDataProvider
//
//  Created by Dmitry Nesterenko on 04.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

/// iOS 9-10 compatible swipe actions configuration
public struct SwipeActionsConfiguration {
    
    public struct ContextualAction {
        
        public enum Style: Int {
            case normal
            case destructive
        }
        
        public var style: Style
        public var handler: (ContextualAction, @escaping (Bool) -> Void) -> Void
        public var title: String?
        public var image: UIImage?

        public init(style: Style, title: String?, handler: @escaping (ContextualAction, @escaping (Bool) -> Void) -> Void) {
            self.style = style
            self.title = title
            self.handler = handler
        }
    }
    
    public var actions: [ContextualAction]
    
    // default YES, set to NO to prevent a full swipe from performing the first action
    public var performsFirstActionWithFullSwipe = true

    public init(actions: [ContextualAction]) {
        self.actions = actions
    }
 
}
