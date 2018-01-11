//
//  CustomViewPresentationController.swift
//  PattyApp
//
//  Created by Dilara Korkmaz on 11/01/2018.
//  Copyright © 2018 Dilara Korkmaz. All rights reserved.
//

import UIKit


enum PresentingDirection {
    case top , right , bottom , left


var bounds : CGRect {
    
    return UIScreen.main.bounds
}

func offSetWithFrame(viewFrame : CGRect) -> CGRect{
    
    switch self{
        
    case .top :
        return viewFrame.offsetBy(dx: 0, dy: -bounds.size.height)
        
    case .bottom :
 
        return viewFrame.offsetBy(dx: 0, dy: bounds.size.height)
    case .left :
 
        return viewFrame.offsetBy(dx: -bounds.size.width, dy: 0)
    case .right :
 
        return viewFrame.offsetBy(dx: bounds.size.width, dy: 0)

        
        
        
        
    }
    
    
    }

    

}

class CustomViewPresentationController: NSObject , UIViewControllerAnimatedTransitioning{
    
    
    
    var presentingDirection : PresentingDirection
    
     init(direction : PresentingDirection) {
        
        self.presentingDirection = direction
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
               let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let finalVCFrame = transitionContext.finalFrame(for: toViewController!)
        let containerView = transitionContext.containerView
        
        toViewController?.view.frame = presentingDirection.offSetWithFrame(viewFrame: finalVCFrame)
        containerView.addSubview((toViewController?.view)!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            
            fromViewController?.view.alpha = 0.5
            toViewController?.view.frame = finalVCFrame
            })
        { (finshed) in
            transitionContext.completeTransition(true)
            fromViewController?.view.alpha = 1.0
            
        }
            
        
        
    }

}
