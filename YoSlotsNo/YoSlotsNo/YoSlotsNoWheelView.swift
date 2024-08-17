//
//  WheelView.swift
//  YoSlotsNo
//
//  Created by jin fu on 2024/8/17.
//

import Foundation
import UIKit

class YoSlotsNoWheelView: UIView {
    
    private let segmentCount = 5
    private let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple]
    private let rewards: [String] = ["BonusSpins", "InstantCash", "Multiplier", "FreeSpins", "Jackpot"]
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let anglePerSegment = CGFloat(2 * Double.pi) / CGFloat(segmentCount)
        
        for i in 0..<segmentCount {
            let startAngle = anglePerSegment * CGFloat(i)
            let endAngle = startAngle + anglePerSegment
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addLine(to: center)
            colors[i].setFill()
            path.fill()
        }
        
        // Draw segment labels
        for i in 0..<segmentCount {
            let angle = anglePerSegment * CGFloat(i) + anglePerSegment / 2
            let x = center.x + radius / 2 * cos(angle)
            let y = center.y + radius / 2 * sin(angle)
            let label = UILabel(frame: CGRect(x: x - 30, y: y - 10, width: 70, height: 20))
            label.text = rewards[i]
            label.textAlignment = .left
            label.textColor = .black
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 11)
            label.transform = CGAffineTransform(rotationAngle: angle)
            addSubview(label)
        }
    }
    
    func spinWheel(completion: @escaping (String) -> Void) {
        let anglePerSegment = CGFloat(2 * Double.pi) / CGFloat(segmentCount)
        let randomIndex = Int(arc4random_uniform(UInt32(segmentCount)))
        let spinAngle = anglePerSegment * CGFloat(randomIndex) + anglePerSegment / 2
        
        UIView.animate(withDuration: 2.0, animations: {
            self.transform = CGAffineTransform(rotationAngle: spinAngle)
        }) { _ in
            completion(self.rewards[randomIndex])
        }
    }
}

