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
        inputBar.inputbarHeightChanged = {height in
            self.bottomConstraint.constant = height
            inputBar.frame.origin.y = self.textView.frame.height+20
        }
        
        let leftButton = NTResponseButton.init(frame: CGRectMake(0, 0, 44, 20))
        leftButton.setTitle("voice", forState: .Normal)
        leftButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        leftButton.backgroundColor =  UIColor.lightGrayColor()
        leftButton.inputAccessoryView = UIView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 200))
        leftButton.addTarget(self, action: #selector(leftButtonTapped), forControlEvents:.TouchUpOutside)
        inputBar.buttonLeft = leftButton
        
        let rightButton = NTResponseButton.init(frame: CGRectMake(0, 0, 44, 20))
        rightButton.setTitle("Ex", forState: .Normal)
        rightButton.setTitleColor(leftButton.titleColorForState(.Normal), forState: .Normal)
        rightButton.backgroundColor = leftButton.backgroundColor
        inputBar.buttonRight = rightButton
        
    }
    
    func leftButtonTapped(sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

