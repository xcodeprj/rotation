//
//  ViewController.swift
//  Rotation
//
//  Created by Chernoev Andrew on 19/05/2019.
//  Copyright © 2019 no_team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var notRotatingView: UIView?
    
//    override var shouldAutorotate: Bool {
//        return false
//    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        notRotatingView?.center = CGPoint(x: view.bounds.midX,
                                         y: view.bounds.midY)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { [weak self] (context) in
            guard let notRotatingView = self?.notRotatingView else {
                return
            }

            let deltaTransform = coordinator.targetTransform
            let deltaAngle: Float = atan2f(Float(deltaTransform.b),
                                           Float(deltaTransform.a))
            if var currentRotation = notRotatingView.layer.value(forKeyPath: "transform.rotation.z") as? Double {
                currentRotation += -1 * Double(deltaAngle) + 0.0001;
                self?.notRotatingView?.layer.setValue(currentRotation,
                                                     forKeyPath: "transform.rotation.z")
            }
        }) { [weak self] (context) in
            guard let notRotatingView = self?.notRotatingView else {
                return
            }
            var currentTransform = notRotatingView.transform
            currentTransform.a = round(currentTransform.a)
            currentTransform.b = round(currentTransform.b)
            currentTransform.c = round(currentTransform.c)
            currentTransform.d = round(currentTransform.d)
            self?.notRotatingView?.transform = currentTransform
        }
    }
}


class ChildPortraitViewController: UIViewController {
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

class ChildLandscapeViewController: UIViewController {
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}
