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
        
        let textView = NTAtTextView.init(frame: CGRectMake(0, 0, 300, 300), textContainer: nil)
        self.view.addSubview(textView)
        textView.placeHolderColor = UIColor.redColor()
        textView.placeHolderString = "please input some tet here"
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        textView.backgroundColor = UIColor.yellowColor()
        textView.layer.cornerRadius = 3.0
        textView.atMentonTrigger = {
            textView.insertMetionedMemberName("JoJo")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

