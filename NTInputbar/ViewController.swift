//
//  ViewController.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/28/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

extension UIScrollView :InputbarAttachedScrollViewProtocol{
     func scrollToBottom() {
        self.setContentOffset(CGPointMake(0, self.contentSize.height - self.frame.size.height), animated: true)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var inputBarIB: NTInputbar!
    
    override var inputAccessoryView: UIView?{
        get{
            return self.inputBarIB
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textView.keyboardDismissMode = .Interactive
        
        let inputBar = self.inputBarIB //NTInputbar.init(frame: CGRectMake(0, 100, 300, 40))
        
        inputBar.textView.placeHolderColor = UIColor.redColor()
        inputBar.textView.placeHolderString = "please input some tet here"
        inputBar.textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        inputBar.textView.backgroundColor = UIColor.yellowColor()
        inputBar.textView.layer.cornerRadius = 3.0
        inputBar.attachedScrollView = self.textView
        inputBar.textView.atMentonTrigger = {
            inputBar.textView.insertMetionedMemberName("JoJo")
        }
        inputBar.inputbarHeightChanged = { [unowned self] height in
            self.bottomConstraint.constant = height
            inputBar.frame.origin.y = self.textView.frame.height+20//status bar height is 20
        }
        
        let leftButton = NTResponderButton.init(frame: CGRectMake(0, 0, 44, 44))
        leftButton.setTitle("voice", forState: .Normal)
        leftButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        leftButton.backgroundColor =  UIColor.lightGrayColor()
        leftButton.inputView = UIView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 100))
        leftButton.inputView?.backgroundColor = UIColor.orangeColor()
        leftButton.addTarget(self, action: #selector(leftButtonTapped), forControlEvents:.TouchUpOutside)
        leftButton.enabled = true
        inputBar.buttonLeft = leftButton
    
        let rightButton = NTResponderButton.init(frame: CGRectMake(0, 0, 44, 44))
        rightButton.setTitle("Ex", forState: .Normal)
        rightButton.setTitleColor(leftButton.titleColorForState(.Normal), forState: .Normal)
        rightButton.backgroundColor = leftButton.backgroundColor
        rightButton.addTarget(self, action: #selector(leftButtonTapped), forControlEvents: .TouchUpInside)
        rightButton.inputView = UIView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 200))
        rightButton.inputView?.backgroundColor = UIColor.redColor()
        inputBar.buttonRight = rightButton
        
        
    }
    
    func leftButtonTapped(sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

