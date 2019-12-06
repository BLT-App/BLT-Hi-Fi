//
//  ObjectView.swift
//  3D Demo
//
//  Created by LorentzenN on 12/3/19.
//  Copyright © 2019 Lorentzen. All rights reserved.
//

import UIKit
import Foundation

class WaterView: UIView, RenderTimerDelegate {
    
    //Path for view
    var path: UIBezierPath!
    //Class to manage rendering the waves on a set interval
    var renderTimer : RenderTimer = RenderTimer()
    //Start Position of Waves
    var currentWaveStart : CGFloat = 0
    //Amplitude of Base Wave
    var amplitude : CGFloat = 10
    //Number of Wave Layers
    var numberOfWaves : Int = 8
    //Vertical Separation Between Waves
    var waveVerticalSeparation : CGFloat = 20
    //Percent of Screen The Wave Will Take Up
    var percentOfFrameFilled : Double = 30
    //Actual Starting Y Value for Base Wave
    var baseYVal : CGFloat {
        return self.frame.height - (CGFloat(self.percentOfFrameFilled) * 0.01 * self.frame.height)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.cyan
        renderTimer = RenderTimer()
        renderTimer.delegate = self
        renderTimer.runTimer(interval: 0.07)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        renderTimer = RenderTimer()
        renderTimer.delegate = self
        renderTimer.runTimer(interval: 0.07)
    }
    
    override func draw(_ rect: CGRect) {
        self.drawWave()
    }
    
    //Called from RenderTimer Class on Interval
    func render() {
        currentWaveStart = currentWaveStart + 0.1
        if currentWaveStart > 4 * CGFloat(Double.pi) {
            currentWaveStart = currentWaveStart - (CGFloat(Double.pi)  * ((currentWaveStart / CGFloat(Double.pi)) - 2))
        }
        self.setNeedsDisplay()
    }
    
    func drawWave() {
        self.path = UIBezierPath()
        var paths : [UIBezierPath] = []
        var yHeight : CGFloat = 0
        var xMod : CGFloat = 0
        for waveNum in 0..<numberOfWaves{
            
            let path1 = UIBezierPath()
            //print(CGFloat(sin(currentWaveStart + xMod)) + yHeight + baseYVal)
            path1.move(to: CGPoint(x: -1, y: CGFloat(sin(currentWaveStart + xMod)) + yHeight + baseYVal))
            for screenLocX in 0..<Int(self.frame.width) {
                let sinInput : CGFloat = currentWaveStart + ((CGFloat(screenLocX) + xMod) / CGFloat((Double.pi * 20)))
                let waveAmplitude : CGFloat = (amplitude * (((CGFloat(waveNum) + 10.0) / (CGFloat(numberOfWaves) + 10.0))))
                path1.addLine(to: CGPoint(x: CGFloat(screenLocX), y: CGFloat(sin(sinInput)) * waveAmplitude + baseYVal + yHeight))
            }
            path1.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            path1.addLine(to: CGPoint(x: 0.0, y: self.frame.height))
            path1.close()
            UIColor(hue: CGFloat(202.0 / 360.0) + (0.001 * CGFloat(waveNum)), saturation: ((35.0 / CGFloat(numberOfWaves)) * CGFloat(waveNum) + 40.0) / 100.0, brightness: 0.8, alpha: (0.82 / (CGFloat(numberOfWaves) + 1)) * (CGFloat(waveNum) + 1.0)).setFill()
            path1.lineWidth = 3.0 / ( (CGFloat(numberOfWaves) - CGFloat(waveNum)) / CGFloat(numberOfWaves) * 2.0 + 1.0)
            path1.fill()
            path1.stroke()
            paths.append(path1)
            yHeight = yHeight + waveVerticalSeparation * ((1.0 / CGFloat(numberOfWaves)) * (CGFloat(numberOfWaves) / (CGFloat(numberOfWaves - waveNum) + 1.0)))
            xMod = xMod + 10
        }
        
        for path2 in paths {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path2.cgPath
        }
    }
    
}
