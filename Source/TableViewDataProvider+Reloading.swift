//
//  TableViewDataProvider+Reloading.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/4/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension TableViewDataProvider {
    
    public func reloadData() {
        guard isTableOwner else { return }
        
        tableView.reloadData()
    }
    
    public func reloadSections(_ sections: IndexSet, animation: UITableViewRowAnimation = .automatic) {
        guard isTableOwner else { return }
        
        tableView.reloadSections(sections, with: .automatic)
    }
    
    public func reloadCells(at paths: [IndexPath], animation: UITableViewRowAnimation = .automatic) {
        guard isTableOwner else { return }
        
        tableView.reloadRows(at: paths, with: animation)
    }
    
}
