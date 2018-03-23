//
//  SegueFromRight.swift
//  CFGC
//
//  Created by Cory on 3/20/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation
import UIKit

class SegueFromRight: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                                   delay: 0.0,
                                   options: .curveEaseInOut,
                                   animations: {
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                                   completion: { finished in
                                    src.present(dst, animated: false, completion: nil)
        }
        )
    }
}
/*
class UIStoryboardUnwindSegueFromRight: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.25,
                                   delay: 0.0,
                                   options: .curveEaseInOut,
                                   animations: {
                                    src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        },
                                   completion: { finished in
                                    src.dismiss(animated: false, completion: nil)
        }
        )
    }
 */

