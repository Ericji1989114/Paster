//
//  SegmentViewController.swift
//  YjiPaster
//
//  Created by 季 雲 on 2017/11/17.
//  Copyright © 2017 Ericji. All rights reserved.
//

import UIKit

class ScrollBgV: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.sublayers?.removeAll()
        let point1 = CGPoint(x: 0, y: self.bounds.height)
        let point2 = CGPoint(x: 0, y: 0)
        let point3 = CGPoint(x: self.bounds.width, y: 0)
        let point4 = CGPoint(x: self.bounds.width, y: self.bounds.height)
        let path = UIBezierPath()
        path.move(to: point2)
        path.addLine(to: point1)
        path.addLine(to: point4)
        path.addLine(to: point3)
        path.close()
        
        let layer = CAShapeLayer()
        let fillColor: UIColor = UIColor(red: 255.0/255.0, green: 227.0/255.0, blue: 228.0/255.0, alpha: 1)
        let stokeColor: UIColor = UIColor(red: 222.0/255.0, green: 82.0/255.0, blue: 89.0/255.0, alpha: 1.0)
        layer.fillColor = fillColor.cgColor
        layer.strokeColor = stokeColor.cgColor
        layer.path = path.cgPath
        layer.lineWidth = 3
        self.layer.addSublayer(layer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 227.0/255.0, blue: 228.0/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private class SegmentBgView: UIView {

    var isSelected = false {
        didSet {
            if self.isSelected {
                self.zoomIn()
            } else {
                self.zoomInEnd()
            }
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.layer.sublayers?.removeAll()
        let point1 = CGPoint(x: 0, y: self.bounds.height)
        let point2 = CGPoint(x: 0, y: 0)
        let point3 = CGPoint(x: self.bounds.width, y: 0)
        let point4 = CGPoint(x: self.bounds.width, y: self.bounds.height)
        let path = UIBezierPath()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)

        let layer = CAShapeLayer()
        let fillColor: UIColor = isSelected ? UIColor(red: 255.0/255.0, green: 227.0/255.0, blue: 228.0/255.0, alpha: 1) : UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        let stokeColor: UIColor = isSelected ? UIColor(red: 222.0/255.0, green: 82.0/255.0, blue: 89.0/255.0, alpha: 1.0) : UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)
        layer.fillColor = fillColor.cgColor
        layer.strokeColor = stokeColor.cgColor
        layer.path = path.cgPath
        layer.lineWidth = 3
        self.layer.addSublayer(layer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func zoomIn() {
        self.layer.removeAllAnimations()
        let bounce = CAKeyframeAnimation(keyPath: "transform")
        let origin = CATransform3DIdentity
        let middle = CATransform3DMakeScale(1, 1.18, 1)
        let best = CATransform3DMakeScale(1, 1.4, 1)
        let originValue = NSValue.init(caTransform3D: origin)
        let middleValue = NSValue.init(caTransform3D: middle)
        let bestValue = NSValue.init(caTransform3D: best)
        bounce.duration = 0.2
        bounce.isRemovedOnCompletion = false
        bounce.fillMode = kCAFillModeForwards
        bounce.values = [originValue, bestValue, middleValue]
        self.layer.add(bounce, forKey: "bounce")
    }
    
    func zoomInEnd() {
        self.layer.removeAllAnimations()
    }
    
}

class SegmentButton: UIView {
    
    private let bgView = SegmentBgView()
    private let titleLbl = UILabel()
    private let selectedStrColor =  UIColor(red: 222.0/255.0, green: 82.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    private let unSelectedStrColor =  UIColor.gray
    
    var isSelected = false {
        didSet {
            bgView.isSelected = self.isSelected
            titleLbl.textColor = self.isSelected ? selectedStrColor : unSelectedStrColor
        }
    }
    
    typealias onTapClousure = () -> Void
    var onTapAction: onTapClousure?
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
        let touch = UITapGestureRecognizer(target: self, action: #selector(self.onTapView(tap:)))
        self.addGestureRecognizer(touch)
        
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLbl.font = UIFont.boldSystemFont(ofSize: 12)
        titleLbl.textAlignment = .center
        titleLbl.textColor = unSelectedStrColor
        titleLbl.text = title
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTapView(tap: UITapGestureRecognizer) {
        if let action = onTapAction {
            self.resetSegment()
            self.isSelected = true
            action()
        }
    }
    
    private func resetSegment() {
        guard let superView = self.superview else{return}
        for subView in superView.subviews {
            if subView is SegmentButton {
                if let subView = subView as? SegmentButton {
                    subView.isSelected = false
                }
            }
        }
    }
}

class SegmentViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let testView = SegmentButton(title: "アピール")
        self.contentView.addSubview(testView)
        testView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(5)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



