//
//  CardView.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/7/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable
    var shape: String = "Squiggle" { didSet { setNeedsDisplay(); setNeedsLayout() } }
//    @IBInspectable
//    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
//    @IBInspectable
//    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    private func drawDiamond(center: CGPoint, path: UIBezierPath) {
        path.move(to: center.offsetBy(dx: 0.0, dy: -(shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: (diamondWidth / 2), dy: 0.0))
        path.addLine(to: center.offsetBy(dx: 0.0, dy: (shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: -(diamondWidth / 2), dy: 0.0))
        path.close()
    }
    
    private func drawOval(center: CGPoint, path: UIBezierPath) {
        path.move(to: center.offsetBy(dx: 0.0, dy: -(shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: -(ovalWidth / 2), dy: -(shapeHeight / 2)))
        path.move(to: center.offsetBy(dx: -(ovalWidth / 2), dy: (shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: (ovalWidth / 2), dy: (shapeHeight / 2)))
        path.move(to: center.offsetBy(dx: (ovalWidth / 2), dy: -(shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: 0.0, dy: -(shapeHeight / 2)))
        path.move(to: center.offsetBy(dx: -(ovalWidth / 2), dy: (shapeHeight / 2)))
        path.addArc(withCenter: center.offsetBy(dx: -(ovalWidth / 2), dy: 0.0), radius: (shapeHeight / 2), startAngle: CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2, clockwise: true)
        path.move(to: center.offsetBy(dx: (ovalWidth / 2), dy: (shapeHeight / 2)))
        path.addArc(withCenter: center.offsetBy(dx: (ovalWidth / 2), dy: 0.0), radius: (shapeHeight / 2), startAngle: CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2, clockwise: false)
    }
    
    private func drawSquiggle(center: CGPoint, path: UIBezierPath) {
        path.move(to: center.offsetBy(dx: (squiggleWidth / 2), dy: -(squiggleHeight / 2) - squigglHeightOffset))
        path.addQuadCurve(to: center.offsetBy(dx: 0.0, dy: -(squiggleHeight / 2)), controlPoint: center.offsetBy(dx: squiggleWidthOffset, dy: -(squiggleHeight / 2) + squigglHeightOffset))
        path.addQuadCurve(to: center.offsetBy(dx: -(squiggleWidth / 2), dy: -(squiggleHeight / 2)), controlPoint: center.offsetBy(dx: -squiggleWidthOffset, dy: -(squiggleHeight / 2) - squigglHeightOffset))
        path.move(to: center.offsetBy(dx: (squiggleWidth / 2), dy: (squiggleHeight / 2) - squigglHeightOffset))
        path.addQuadCurve(to: center.offsetBy(dx: 0.0, dy: (squiggleHeight / 2)), controlPoint: center.offsetBy(dx: squiggleWidthOffset, dy: (squiggleHeight / 2) + squigglHeightOffset))
        path.addQuadCurve(to: center.offsetBy(dx: -(squiggleWidth / 2), dy: (squiggleHeight / 2)), controlPoint: center.offsetBy(dx: -squiggleWidthOffset, dy: (squiggleHeight / 2) - squigglHeightOffset))
        path.move(to: center.offsetBy(dx: -(squiggleWidth / 2), dy: -(squiggleHeight / 2)))
        path.addLine(to: center.offsetBy(dx: -(squiggleWidth / 2), dy: (squiggleHeight / 2)))
        path.move(to: center.offsetBy(dx: (squiggleWidth / 2), dy: (squiggleHeight / 2) - squigglHeightOffset))
        path.addLine(to: center.offsetBy(dx: (squiggleWidth / 2), dy: -(squiggleHeight / 2) - squigglHeightOffset))
    }
    
    override func draw(_ rect: CGRect) {
        
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        let shapePath = UIBezierPath()
        if shape == "Diamond" {
            var shapeCenter = CGPoint(x: bounds.topHalf.midX, y: bounds.topHalf.midY)
            drawDiamond(center: shapeCenter, path: shapePath)
            shapeCenter = CGPoint(x: bounds.midX, y: bounds.midY)
            drawDiamond(center: shapeCenter, path: shapePath)
            shapeCenter = CGPoint(x: bounds.bottomHalf.midX, y: bounds.bottomHalf.midY)
            drawDiamond(center: shapeCenter, path: shapePath)
        } else if shape == "Oval" {
            var shapeCenter = CGPoint(x: bounds.topHalf.midX, y: bounds.topHalf.midY)
            drawOval(center: shapeCenter, path: shapePath)
            shapeCenter = CGPoint(x: bounds.midX, y: bounds.midY)
            drawOval(center: shapeCenter, path: shapePath)
            shapeCenter = CGPoint(x: bounds.bottomHalf.midX, y: bounds.bottomHalf.midY)
            drawOval(center: shapeCenter, path: shapePath)
        } else if shape == "Squiggle" {
            var shapeCenter = CGPoint(x: bounds.topHalf.midX, y: bounds.topHalf.midY)
            drawSquiggle(center: shapeCenter, path: shapePath)
            shapeCenter = CGPoint(x: bounds.midX, y: bounds.midY)
            drawSquiggle(center: shapeCenter, path: shapePath)
            shapeCenter = CGPoint(x: bounds.bottomHalf.midX, y: bounds.bottomHalf.midY)
            drawSquiggle(center: shapeCenter, path: shapePath)
        }
        
        shapePath.lineWidth = 5.0
        UIColor.green.setStroke()
        shapePath.stroke()
    }

}

extension CardView {
    private struct SizeRatio {
        static let shapeHeightRatio: CGFloat = 0.19
        static let diamondWidthRatio: CGFloat = 0.63
        static let ovalWidthRatio: CGFloat = 0.4
        static let squiggleWidthRatio: CGFloat = 0.63
        static let squiggleHeightRatio: CGFloat = 0.14
        static let squiggleHeightOffsetRatio: CGFloat = 0.12
        static let squiggleWidthOffsetRatio: CGFloat = 0.20
        static let squiggleEndWidthOffsetRatio: CGFloat = 0.14
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var shapeHeight: CGFloat {
        return bounds.size.height * SizeRatio.shapeHeightRatio
    }
    private var diamondWidth: CGFloat {
        return bounds.size.width * SizeRatio.diamondWidthRatio
    }
    private var ovalWidth: CGFloat {
        return bounds.size.width * SizeRatio.ovalWidthRatio
    }
    private var squiggleWidth: CGFloat {
        return bounds.size.width * SizeRatio.squiggleWidthRatio
    }
    private var squiggleHeight: CGFloat {
        return bounds.size.height * SizeRatio.squiggleHeightRatio
    }
    private var squigglHeightOffset: CGFloat {
        return bounds.size.width * SizeRatio.squiggleHeightOffsetRatio
    }
    private var squiggleWidthOffset: CGFloat {
        return bounds.size.width * SizeRatio.squiggleWidthOffsetRatio
    }
    private var squiggleEndWidthOffset: CGFloat {
        return bounds.size.width * SizeRatio.squiggleEndWidthOffsetRatio
    }
}

extension CGRect {
    var topHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height/2)
    }
    var bottomHalf: CGRect {
        return CGRect(x: minX, y: midY, width: width, height: height/2)
    }
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
