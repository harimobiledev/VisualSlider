//
//  ViewController.swift
//  Slider
//
//  Created by Hari Keerthipati on 09/10/18.
//  Copyright © 2018 Avantari Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var visualSlider: VisualSlider!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        visualSlider.delegate = self
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        visualSlider.value = 90.0
    }
    
    @IBAction func incrementButtonAction(sender: UIButton) {
        print("self.visualSlider.value===\(self.visualSlider.value)")
        self.visualSlider.value = self.visualSlider.value + 1.0
    }
    
    @IBAction func decrementButtonAction(sender: UIButton) {
        print("self.visualSlider.value===\(self.visualSlider.value)")
        self.visualSlider.value = self.visualSlider.value - 1.0
    }
    
    func changeImageViewAlpha(with percentage: Double)
    {
        self.imageView.alpha = CGFloat(percentage / 100)
    }
}

extension ViewController: VisualSliderDelegate {
    
    func visualSlider(visualSlider: VisualSlider, percentage: Double) {
        
        changeImageViewAlpha(with: percentage)
        print("slider value===\(percentage)")
    }
}
