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
        
        let firstSection = SectionDescriptor(rows: [firstCell])
        
        firstSection.isVisiblie = false
        
        let firstCell1 = CellDescriptor(configuration: {
            (cell: TestTableViewCell) in
            
            cell.mainLabel.text = "Some text 1"
            cell.secondLabel.text = "Multi\nline\ntext\n"
            cell.separatorPositions = [.bottom(offsets: .zero)]
        })
        
        let firstCell2 = CellDescriptor(configuration: {
            (cell: TestTableViewCell) in
            
            cell.mainLabel.text = "Some text 2 "
            cell.secondLabel.text = "Multi\nline\ntext\n"
            cell.separatorPositions = [.bottom(offsets: .zero)]
        })
        firstCell2.isVisible = false
        
        let firstCell3 = CellDescriptor(configuration: {
            (cell: TestTableViewCell) in
            
            cell.mainLabel.text = "Some text 3"
            cell.secondLabel.text = "Multi\nline\ntext\n"
            cell.separatorPositions = [.bottom(offsets: .zero)]
        })
        
        let secondSection = SectionDescriptor(rows: [firstCell1, firstCell2, firstCell3])
        
        dataProvider.sections = [firstSection, secondSection]
        dataProvider.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.dataProvider.setSection(at: 0, visible: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.tableView.beginUpdates()
            self.dataProvider.setRow(at: IndexPath.init(row: 1, section: 1), visible: true)
            self.dataProvider.setRow(at: IndexPath.init(row: 2, section: 1), visible: false)
            self.tableView.endUpdates()
        }
    }
    
}

