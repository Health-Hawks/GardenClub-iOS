//
//  InfoSwipeRightToLeft.swift
//  CFGC
//
//  Created by Cory on 3/19/18.
//  Copyright © 2018 Tabor Scott. All rights reserved.
//

import Foundation
import UIKit

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
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
class SwipeRightToLeftSegue: UIStoryboardSegue{
    
    override func perform() {
        
        let firstVC = self.source.view as UIView!
        let secondVC = self.destination.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        secondVC.frame = CGRectMake(-screenWidth, 0, screenWidth, screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindowwindow?.insertSubview(secondVC, aboveSubview: firstVC)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in // set animation duration
            
            firstVC.frame = CGRectOffset(firstVC.frame, 0.0, 0.0) // old screen stay
            
            secondVC.frame = CGRectOffset(secondVC.frame, screenWidth, 0.0) // new screen strave from left to right
            
        }) { (Finished) -> Void in
            self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                                                            animated: false,
                                                            completion: nil)
        }
    }
    
}
*/
