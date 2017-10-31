//
//  ViewController.swift
//  Example
//
//  Created by Ilya Kulebyakin on 10/3/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit
import TableViewDataProvider

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataProvider: TableViewDataProvider = {
        return TableViewDataProvider(tableView: tableView, customHeaders: true)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstCell = CellDescriptor(configuration: {
            (cell: TestTableViewCell) in
            
            cell.mainLabel.text = "Some text"
            cell.secondLabel.text = "Multi\nline\ntext\n"
            cell.separatorPositions = [.bottom(offsets: .zero)]
        })
        
        let header = SectionDescriptor.HeaderFooterDescriptor(configuration: {
            (header: TestHeader) in
            
            header.titleLabel.text = "awgaweg\nawefawf\nawefa\n"
        })
        
        let firstSection = SectionDescriptor(header: header, footer: .text("w\nf\na\n\n\n\n\n\nwf\nawef\n"), rows: [firstCell])
        
        dataProvider.sections = [firstSection]
        dataProvider.reloadData()
    }
    
}

