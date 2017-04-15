//
//  ViewController.swift
//  WeekGraph
//
//  Created by Kirill Netavskiy on 15.04.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var sunDay: UILabel!
    @IBOutlet var monDay: UILabel!
    @IBOutlet var tuesDay: UILabel!
    @IBOutlet var wensDay: UILabel!
    @IBOutlet var thursDay: UILabel!
    @IBOutlet var friDay: UILabel!
    @IBOutlet var saturDay: UILabel!
    
    @IBOutlet var sunDayHeight: NSLayoutConstraint!
    @IBOutlet var monDayHeight: NSLayoutConstraint!
    @IBOutlet var tuesDayHeight: NSLayoutConstraint!
    @IBOutlet var wensDayHeight: NSLayoutConstraint!
    @IBOutlet var thursDayHeight: NSLayoutConstraint!
    @IBOutlet var friDayHeight: NSLayoutConstraint!
    @IBOutlet var saturDayHeight: NSLayoutConstraint!
    
    var timer: Timer!
    var refresher: UIRefreshControl!
    var loop: CGFloat = 10
    var tempLoop: CGFloat = 0
    var height: CGFloat = 0
    var width: CGFloat = 0
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Add the view to the view hierarchy so that it shows up on screen
        let frame = UIScreen.main.bounds
        height = frame.height
        width = frame.width
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: Selector(("refresh:")), for: .valueChanged)
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(refreshEvery03Secs), userInfo: nil, repeats: true)
        
    }

    func refreshEvery03Secs() {
        loop = loop + 10
        if loop != 60 {
            setHeight(loop: loop, height: sunDayHeight, label: sunDay)
            setHeight(loop: loop, height: monDayHeight, label: monDay)
        } else {
            timer.invalidate()
            timer = nil
        }
    }
    
    func setHeight(loop: CGFloat, height: NSLayoutConstraint, label: UILabel) {
        label.backgroundColor = UIColor.black
        view.setNeedsDisplay()
        height.constant = height.constant + loop
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        label.addGestureRecognizer(tap)
        tempLoop = height.constant
        
        
    }
    
    func tapFunction() {
        print(tempLoop)
    }
    
    func drawLines() {
        view.bounds.height
    }
    
}

