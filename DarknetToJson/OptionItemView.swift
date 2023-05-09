//
//  OptionItemView.swift
//  Annotation-Converter
//
//  Created by Mac8 on 09/05/2023.
//

import Cocoa

class OptionItemView: NSCollectionViewItem {
    @IBOutlet weak var fromLabel:NSTextField!
    @IBOutlet weak var toLabel:NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.cornerRadius = 8.0
        view.layer?.backgroundColor = NSColor.purple.cgColor
    }
    
    func configureCell(_ from:String, to:String) {
//        fromLabel.stringValue = from
//        toLabel.stringValue = to
//        debugPrint(fromLabel.stringValue)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        fromLabel.stringValue = "from"
    }
}
