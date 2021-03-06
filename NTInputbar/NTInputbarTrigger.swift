//
//  NTInputbarTrigger.swift
//  NTGrowInputbar
//
//  Created by Nicholas Tau on 3/31/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class NTInputbarTrigger: NTResponderButton {

    var triggerAccessoryView : NTGrowInputbar?
    private var scrollView :UIScrollView?
    private var offsetY :CGFloat? = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    override func commitInit() {
        super.commitInit()
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(keyboardWillshow),
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @objc private func keyboardWillshow(notification :NSNotification)  {
        if let userInfo = notification.userInfo {
            if self.scrollView != nil{
                let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
                let currentContentOffset = self.scrollView?.contentOffset
                let applicationFrame = UIScreen.mainScreen().bounds
                let newContentOffsetY = self.offsetY! - (applicationFrame.size.height - frameValue.CGRectValue().size.height) + 64.0
                var newContentOffset = CGPointMake((currentContentOffset?.x)!, newContentOffsetY)
                newContentOffset.y = newContentOffset.y <= 0 ? 0 : newContentOffset.y;
                self.scrollView?.setContentOffset(newContentOffset, animated: true)
            }
        }
    }
    
    
    //public API
    func showInputbarInTableview(tableview :UITableView, indexPath :NSIndexPath) {
        let selectRect = tableview.rectForRowAtIndexPath(indexPath)
        showInputbarInScollView(tableview, offsetY: selectRect.origin.y+selectRect.size.height)
    }
    
    func showInputbarInCollectionView(collectionView :UICollectionView, indexPath :NSIndexPath){
        let layoutAttribute = collectionView.collectionViewLayout.layoutAttributesForItemAtIndexPath(indexPath)
        if let attribute = layoutAttribute {
            showInputbarInScollView(collectionView, offsetY: attribute.frame.origin.y + attribute.frame.size.height)
        }
    }
    
    func showInputbarInScollView(scrollView :UIScrollView, offsetY :CGFloat) {
        self.scrollView = scrollView
        self.offsetY = offsetY
        self.becomeFirstResponder()
    }
    
    override func endEditing(force: Bool) -> Bool {
        self.scrollView = nil
        self.offsetY = 0.0
        return super.endEditing(force)
    }
    
    override func becomeFirstResponder() -> Bool {
        let responderResult = super.becomeFirstResponder()
        if let accessoryView = self.triggerAccessoryView {
            return accessoryView.textView.becomeFirstResponder()
        }else{
            return responderResult
        }
    }
    
    func resetTriggerAccessoryView(accessoryView :NTGrowInputbar) {
        self.triggerAccessoryView = accessoryView
        accessoryView.textView.inputAccessoryView = nil
    }
    
    override var inputAccessoryView: UIView?{
        get{
            return triggerAccessoryView
        }set{
            if (newValue as? NTGrowInputbar) != nil {
                triggerAccessoryView = newValue as? NTGrowInputbar
            }
        }
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
