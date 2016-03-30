//
//  ViewController.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/28/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let inputBar = NTInputbar.init(frame: CGRectMake(0, 100, 300, 40))
        self.view.addSubview(inputBar)
        inputBar.textView.placeHolderColor = UIColor.redColor()
        inputBar.textView.placeHolderString = "please input some tet here"
        inputBar.textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        inputBar.textView.backgroundColor = UIColor.yellowColor()
        inputBar.textView.layer.cornerRadius = 3.0
        inputBar.textView.atMentonTrigger = {
            inputBar.textView.insertMetionedMemberName("JoJo")
        }
        
        let leftButton = NTResponseButton.init(frame: CGRectMake(0, 0, 44, 44))
        leftButton.setTitle("voice", forState: .Normal)
        inputBar.buttonLeft = leftButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

