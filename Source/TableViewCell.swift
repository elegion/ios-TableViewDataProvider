//
//  TableViewCell.swift
//  Pods-Example
//
//  Created by Ilya Kulebyakin on 10/3/17.
//

import Foundation

public enum LinePosition {
    
    public struct HorizontalOffsets {
        public let left: CGFloat
        public let right: CGFloat
        
        public init(left: CGFloat, right: CGFloat) {
            self.left = left
            self.right = right
        }
        
        public static var zero: HorizontalOffsets {
            return HorizontalOffsets(left: 0.0, right: 0.0)
        }
    }
    
    public struct VerticalOffsets {
        public let top: CGFloat
        public let bottom: CGFloat
        
        public init(top: CGFloat, bottom: CGFloat) {
            self.top = top
            self.bottom = bottom
        }
        
        public static var zero: VerticalOffsets {
            return VerticalOffsets(top: 0.0, bottom: 0.0)
        }
    }
    
    case top(offsets: HorizontalOffsets)
    case right(offsets: VerticalOffsets)
    case bottom(offsets: HorizontalOffsets)
    case left(offsets: VerticalOffsets)
}

open class TableViewCell: UITableViewCell {
    
    private struct Consts {
        static let defaultSeparatorWidth: CGFloat = 1.0 / UIScreen.main.scale
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        separatorPositions = []
        separatorColor = nil
        separatorWidth = Consts.defaultSeparatorWidth
    }
    
    open class var estimatedHeight: CGFloat {
        return height ?? 44.0
    }
    
    open class var height: CGFloat? {
        return nil
    }
    
    public var separatorPositions: [LinePosition] = [] {
        didSet {
            setNeedsLayout()
        }
    }
    public var separatorColor: UIColor? = .lightGray {
        didSet {
            setNeedsLayout()
        }
    }
    public var separatorWidth: CGFloat = Consts.defaultSeparatorWidth {
        didSet {
            setNeedsLayout()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.setSeparators(separatorPositions.map { ($0, separatorColor, separatorWidth) })
    }
    
}
