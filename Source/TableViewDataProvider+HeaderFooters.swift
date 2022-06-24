//
//  TableViewDataProvider+HeaderFooters.swift
//  TableViewDataProvider
//
//  Created by Ilya Kulebyakin on 10/20/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation
import UIKit

extension TableViewDataProvider {
    
    public override func responds(to aSelector: Selector!) -> Bool {
        guard !customHeaderFooters else {
            return super.responds(to: aSelector)
        }
        
        let headerFooterHeigthSelectors = [
            #selector(tableView(_:heightForFooterInSection:)),
            #selector(tableView(_:estimatedHeightForHeaderInSection:)),
            #selector(tableView(_:heightForHeaderInSection:)),
            #selector(tableView(_:estimatedHeightForFooterInSection:)),
            ]
        
        if headerFooterHeigthSelectors.contains(aSelector) {
            return false
        } else {
            return super.responds(to: aSelector)
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionDescriptor = sections[section]
        
        switch sectionDescriptor.header {
        case .text(let title):
            return title
        default:
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let sectionDescriptor = sections[section]
        
        switch sectionDescriptor.footer {
        case .text(let title):
            return title
        default:
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let sectionDescriptor = sections[section]

        return estimatedHeight(from: sectionDescriptor.header)
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let sectionDescriptor = sections[section]

        return estimatedHeight(from: sectionDescriptor.footer)
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionDescriptor = sections[section]

        return height(from: sectionDescriptor.footer)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionDescriptor = sections[section]
        
        return height(from: sectionDescriptor.header)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let descriptor = sections[section].header
        return headerFooterView(for: descriptor, from: tableView)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let descriptor = sections[section].footer
        return headerFooterView(for: descriptor, from: tableView)
    }
    
    private func headerFooterView(for descriptor: SectionDescriptor.HeaderFooterDescriptor, from tableView: UITableView) -> UIView? {
        switch descriptor {
        case .none, .text:
            return nil
        case .configuration(let headerClass, let configuration):
            registerHeaderFooterIfNeeded(descriptor, in: tableView)
            
            let cell = tableView.tp_dequeueHeaderFooter(of: headerClass)
            
            configuration(cell)
            
            return cell
        }
    }
    
    private func registerHeaderFooterIfNeeded(_ descriptor: SectionDescriptor.HeaderFooterDescriptor, in tableView: UITableView) {
        guard let reuseIdentifier = descriptor.reuseIdentifier,
            case SectionDescriptor.HeaderFooterDescriptor.configuration(let headerFooterClass, _) = descriptor,
            !registeredCellIdentifiers.contains(reuseIdentifier) else {
            return
        }
        
        registeredHeaderFooterIdentifiers.insert(reuseIdentifier)
        tableView.tp_register(headerFooterType: headerFooterClass)
    }
    
    private func estimatedHeight(from descriptor: SectionDescriptor.HeaderFooterDescriptor) -> CGFloat {
        switch descriptor {
        case .text:
            debugPrint("WARNING!! Using titleForHeader or titlerForFooter with customHeaderFooters is strongly unsuggested")
            return 0.0
        case .configuration(let headerFooterClass, _):
            return headerFooterClass.estimatedHeight
        case .none:
            return 0.0
        }
    }
    
    private func height(from descriptor: SectionDescriptor.HeaderFooterDescriptor) -> CGFloat {
        switch descriptor {
        case .text:
            debugPrint("WARNING!! Using titleForHeader or titlerForFooter with customHeaderFooters is strongly unsuggested")
            return UITableView.automaticDimension
        case .configuration(let headerFooterClass, _):
            return headerFooterClass.height ?? UITableView.automaticDimension
        case .none:
            return 0.0
        }
    }
    
}
