//
//  CircularProgressView.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-29.
//

import UIKit

class CircularProgressView: UIView {
    var trackBackgroundColor = UIColor.lightGray
    var trackBorderWidth: CGFloat = 10
    var progressColor = UIColor.green
    var percent: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    static let startDegrees: CGFloat = 120
    static let endDegrees: CGFloat = 60

    override func draw(_ rect: CGRect) {
        let startAngle: CGFloat = radians(of: CircularProgressView.startDegrees)
        let endAngle: CGFloat = radians(of: CircularProgressView.endDegrees)
        let progressAngle = radians(of: CircularProgressView.startDegrees + (360 - CircularProgressView.startDegrees + CircularProgressView.endDegrees) * CGFloat(max(0.0, min(percent, 1.0))))

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(center.x, center.y) - trackBorderWidth / 2 - 10

        let trackPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: true)
        trackPath.lineWidth = trackBorderWidth
        trackPath.lineCapStyle = .round
        progressPath.lineWidth = trackBorderWidth
        progressPath.lineCapStyle = .round

        trackBackgroundColor.set()
        trackPath.stroke()

        progressColor.set()
        progressPath.stroke()
    }

    private func radians(of degrees: CGFloat) -> CGFloat {
        return degrees / 180 * .pi
    }
}

//let progress = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 500, height: 400))
//progress.backgroundColor = .white
//progress.percent = 0.95
