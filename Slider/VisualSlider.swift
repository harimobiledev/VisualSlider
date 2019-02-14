//
//  VisualSlider.swift
//  Slider
//
//  Created by Hari Keerthipati on 09/10/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import UIKit

protocol VisualSliderDelegate {
    func visualSlider(visualSlider: VisualSlider, percentage: Double)
}

class VisualSlider: UIView {

    var delegate: VisualSliderDelegate?
    private var lightVisualView: UIVisualEffectView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addVisualView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layout subviews")
    }
    
    var value: Double = 0.0 {
        
        didSet {
            if value < 0
            {
                value = 0
            }
            else if value > 100
            {
                value = 100
            }
            setPercentage(percentage: value)
            self.delegate?.visualSlider(visualSlider: self, percentage: value)
        }
    }
    
    fileprivate func addVisualView()
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20.0
        let darkVisualView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        darkVisualView.frame = self.bounds
        addSubview(darkVisualView)
        
        lightVisualView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
        lightVisualView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: self.frame.size.height)
        addSubview(lightVisualView)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned(panGesture:)))
        addGestureRecognizer(panGesture)
    }
    
    var transitionChange:CGFloat = 0.0
    @objc func panned(panGesture: UIPanGestureRecognizer)
    {
        if panGesture.state == .began
        {
            let translation = panGesture.translation(in: self)
            transitionChange = translation.x
        }
        if panGesture.state == .changed
        {
            let translation = panGesture.translation(in: self)
            let change = translation.x - transitionChange
            self.change(inWidth: change)
            self.sliderProgressChanged()
            transitionChange = translation.x
        }
    }
    
    fileprivate func change(inWidth width: CGFloat) {
        var finalWidth = lightVisualView.frame.size.width + width
        if finalWidth < 0
        {
            finalWidth = 0
        }
        else if finalWidth > self.frame.size.width
        {
            finalWidth = self.frame.size.width
        }
        lightVisualView.frame = CGRect(x: 0.0, y: 0.0, width: finalWidth, height: self.frame.size.height)
    }
    
    fileprivate func setPercentage(percentage: Double)
    {
        UIView.animate(withDuration: 0.1) {
            self.lightVisualView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width * CGFloat(percentage/100.0), height: self.frame.size.height)
        }
    }
    
    fileprivate func sliderProgressChanged()
    {
        self.value = Double((lightVisualView.frame.size.width / self.frame.size.width) * 100.0)
    }
}

