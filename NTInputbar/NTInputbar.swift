//
//  NTInputbar.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/28/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class NTInputbar: UIView {
    
    var buttonLeft: UIButton?{
        willSet{
            buttonLeft?.removeFromSuperview()
        }
        didSet{
            self.setNeedsLayout()
        }
    }
    var buttonRight: UIButton?{
        willSet{
            buttonRight?.removeFromSuperview()
        }
        didSet{
            self.setNeedsLayout()
        }
    }
    let textView = NTAtTextView.init(frame: CGRectZero, textContainer: nil)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    func commitInit() {
        self.addSubview(textView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    

}
