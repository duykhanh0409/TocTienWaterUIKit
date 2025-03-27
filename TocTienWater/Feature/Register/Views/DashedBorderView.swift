//
//  DashedBorderView.swift
//  TocTienWater
//
//  Created by Tuan Bui on 18/3/25.
//

import UIKit

class DashedBorderView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.sublayers?.removeAll(where: { $0 is CAShapeLayer })
        
        let dashedBorder = CAShapeLayer()
        dashedBorder.strokeColor = UIColor(hexString: "#2B6469")?.cgColor
        dashedBorder.lineDashPattern = [10, 15]
        dashedBorder.frame = self.bounds
        dashedBorder.fillColor = nil
        dashedBorder.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath
        dashedBorder.lineWidth = 1
        
        self.layer.addSublayer(dashedBorder)
    }
}
