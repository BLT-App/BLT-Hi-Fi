//
//  Additional Classes.swift
//  BLT
//
//  Created by Jiahua Chen on 11/26/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation
import UIKit

class CustomIntensityVisualEffectView: UIVisualEffectView {
    
    /// Create visual effect view with given effect and its intensity
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = effect }
        animator.fractionComplete = intensity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Private
    private var animator: UIViewPropertyAnimator!
    
}
