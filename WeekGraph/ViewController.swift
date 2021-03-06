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
    
    var sunDayMax: CGFloat = 0
    var monDayMax: CGFloat = 0
    var tueDayMax: CGFloat = 0
    var wenDayMax: CGFloat = 0
    var thuDayMax: CGFloat = 0
    var friDayMax: CGFloat = 0
    var satDayMax: CGFloat = 0
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var heightToLabel: NSLayoutConstraint!
    
    
    var timer: Timer!
    var refresher: UIRefreshControl!
    var loop: CGFloat = 10
    var tempLoop: CGFloat = 0
    var height: CGFloat = 0
    var width: CGFloat = 0
    var tempString = ""
    var label = UILabel()
    var topHeight = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add the view to the view hierarchy so that it shows up on screen
        let frame = UIScreen.main.bounds
        height = frame.height
        width = frame.width
        height = height - heightToLabel.constant
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: Selector(("refresh:")), for: .valueChanged)
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(refreshEvery03Secs), userInfo: nil, repeats: true)
        sunDayMax = setMaxValue()
        monDayMax = setMaxValue()
        tueDayMax = setMaxValue()
        wenDayMax = setMaxValue()
        thuDayMax = setMaxValue()
        friDayMax = setMaxValue()
        satDayMax = setMaxValue()
        addGesture()
        drawLines()
    }
    
    func refreshEvery03Secs() {
        if loop != (height - heightToLabel.constant) {
            setMaxLoop(maxLoop: sunDayMax, loop: loop, height: sunDayHeight, label: sunDay)
            setMaxLoop(maxLoop: monDayMax, loop: loop, height: monDayHeight, label: monDay)
            setMaxLoop(maxLoop: tueDayMax, loop: loop, height: tuesDayHeight, label: tuesDay)
            setMaxLoop(maxLoop: wenDayMax, loop: loop, height: wensDayHeight, label: wensDay)
            setMaxLoop(maxLoop: thuDayMax, loop: loop, height: thursDayHeight, label: thursDay)
            setMaxLoop(maxLoop: friDayMax, loop: loop, height: friDayHeight, label: friDay)
            setMaxLoop(maxLoop: satDayMax, loop: loop, height: saturDayHeight, label: saturDay)
            loop += 10
        } else {
            timer.invalidate()
            timer = nil
        }
    }
    
    func setHeight(loop: CGFloat, height: NSLayoutConstraint, label: UILabel) {
        label.backgroundColor = UIColor.black
        view.setNeedsDisplay()
        height.constant = loop
    }
    
    func setMaxLoop(maxLoop: CGFloat, loop: CGFloat, height: NSLayoutConstraint, label: UILabel) {
        if loop <= maxLoop {
            setHeight(loop: loop, height: height, label: label)
        } else {
            setHeight(loop: maxLoop, height: height, label: label)
            
        }
        getValue(value: maxLoop/CGFloat((self.height - heightToLabel.constant)/40), label: label)
    }
    
    func setMaxValue() -> CGFloat {
        return  CGFloat(Double(arc4random_uniform(40) + 1) * Double((height - heightToLabel.constant)/40))
    }
    
    func getValue(value: CGFloat, label: UILabel) {
        label.text = String(describing: Int(value))
    }
    
    func addGesture() {
        let sundayTap = UITapGestureRecognizer(target: self, action: #selector(sundayTapFunc))
        sunDay.addGestureRecognizer(sundayTap)
        let mondayTap = UITapGestureRecognizer(target: self, action: #selector(mondayTapFunc))
        monDay.addGestureRecognizer(mondayTap)
        let tuesdayTap = UITapGestureRecognizer(target: self, action: #selector(tuesdayTapFunc))
        tuesDay.addGestureRecognizer(tuesdayTap)
        let wensdayTap = UITapGestureRecognizer(target: self, action: #selector(wensdayTapFunc))
        wensDay.addGestureRecognizer(wensdayTap)
        let thursdayTap = UITapGestureRecognizer(target: self, action: #selector(thursdayTapFunc))
        thursDay.addGestureRecognizer(thursdayTap)
        let fridayTap = UITapGestureRecognizer(target: self, action: #selector(fridayTapFunc))
        friDay.addGestureRecognizer(fridayTap)
        let saturdayTap = UITapGestureRecognizer(target: self, action: #selector(saturdayTapFunc))
        saturDay.addGestureRecognizer(saturdayTap)
    }
    
    func sundayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: sunDay.text!)
        
    }
    
    func mondayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: monDay.text!)
    }
    
    func tuesdayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: tuesDay.text!)
    }
    
    func wensdayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: wensDay.text!)
    }
    
    func thursdayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: thursDay.text!)
    }
    
    func fridayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: friDay.text!)
    }
    
    func saturdayTapFunc(sender: UITapGestureRecognizer) {
        createToolTip(sender: sender, text: saturDay.text!)
    }
    
    func createToolTip(sender: UITapGestureRecognizer, text: String) {
        var touchLocation = CGPoint()
        label.removeFromSuperview()
        switch sender.state {
        case .ended:
            touchLocation = sender.location(in: mainView)
        default:
            print("another state")
        }
        label = UILabel(frame: CGRect(origin: touchLocation, size: CGSize(width: 30, height: 30)))
        label.text = text
        label.backgroundColor = UIColor.yellow
        view.addSubview(label)
        view.layoutIfNeeded()
    }
    
    func drawLines() {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        let quaterOfHeight = (height - heightToLabel.constant)/4
        var count = 0
        var tempHeigth = height
        while count != 5 {
            
            linePath.move(to: CGPoint(x: 0, y: tempHeigth))
            linePath.addLine(to: CGPoint(x: width, y: tempHeigth))
            line.path = linePath.cgPath
            line.strokeColor = UIColor.red.cgColor
            line.lineWidth = 1
            line.lineJoin = kCALineJoinRound
            self.view.layer.addSublayer(line)
            tempHeigth = tempHeigth - quaterOfHeight
            count += 1
        }
    }
    
    
}


