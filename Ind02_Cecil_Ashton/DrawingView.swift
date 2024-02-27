//
//  DrawingView.swift
//  Ind02_Cecil_Ashton
//
//  Created by Ashton Cecil on 2/27/24.
//

import UIKit

class DrawingView: UIView {

    var lake: UIImage? = UIImage(named: "lakeLouiseOne.png")
    
    func drawLakeLouise(){
        guard let lake = self.lake else{
            print("**** Cannot find Lake! ****")
            return
        }
    
    let p = CGPoint(
    x: (self.bounds.size.width - lake.size.width) / 2,
    y: (self.bounds.size.height - lake.size.height) / 2)
        lake.draw(at: p)
    }
    
    override func draw(_ rect: CGRect){
        drawLakeLouise()
    }
}
