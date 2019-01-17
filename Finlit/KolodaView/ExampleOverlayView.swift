//
//  ExampleOverlayView.swift
//  KolodaView
//
//  Created by Eugene Andreyev on 6/21/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    
    @IBOutlet lazy var overlayImageView: UIView! = {
        [unowned self] in
        
        var imageView = UIView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
        }()

    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left? :
            print("34")
            //  overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                print("34")
               // overlayImageView.image = UIImage(named: overlayRightImageName)
            case .topRight? :
                print("356")
            default:
                print("hello")
            }
        }
    }

}
