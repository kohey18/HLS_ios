//
//  AVPlayerView.swift
//  GNChannel
//
//  Created by kohey on 2015/11/23.
//  Copyright © 2015年 kohey. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerView: UIView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.self
    }
}
