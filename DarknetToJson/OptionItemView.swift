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
    }
    
    func configureCell(_ option:ConverterOption) {
        toLabel.stringValue = option.toValue
        fromLabel.stringValue = option.fromValue
        if option.enabled {
            view.layer?.backgroundColor = NSColor.purple.cgColor
        }
        else {
            view.layer?.backgroundColor = NSColor.lightGray.cgColor
        }
    }
}
