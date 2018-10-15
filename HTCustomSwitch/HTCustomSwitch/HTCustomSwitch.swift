//
//  HTCustomSwitch.swift
//  HTCustomSwitch
//
//  Created by UltraHigh on 10/15/18.
//  Copyright © 2018 HT. All rights reserved.
//

import UIKit

public protocol HTCustomSwitchDelegate: class {
    func valueChanged(sender: HTCustomSwitch)
}

@IBDesignable
public class HTCustomSwitch: UIView {
    
    //MARK: - PROPERTIES
    weak public var delegate: HTCustomSwitchDelegate?
    
    private var ball = UIView()
    private var container = UIView()
    
    private var ballOnFrame = CGRect.zero
    private var ballOffFrame = CGRect.zero
    
    private let ballAnimates = CAAnimationGroup()
    private let ballXPosAnimate = CABasicAnimation(keyPath: "position.x")
    private let ballCornerRadiusAnimate = CABasicAnimation(keyPath: "cornerRadius")
    private let ballSizeAnimate = CABasicAnimation(keyPath: "bounds.size")
    private let ballBGColorAniamte = CABasicAnimation(keyPath: "backgroundColor")
    
    private let containerAnimates = CAAnimationGroup()
    private let containerBGColorAniamte = CABasicAnimation(keyPath: "backgroundColor")
    private let containerBorderColorAnimate = CABasicAnimation(keyPath: "borderColor")
    
    //MARK: - CUSTOM UI
    @IBInspectable public var isOn: Bool = true {
        didSet {
            setToCurrentState()
        }
    }
    
    @IBInspectable public var onBallSize: CGFloat = 0 {
        didSet {
            configBallOn()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var onBallColor: UIColor = UIColor.white {
        didSet {
            configBallOn()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var onColorContainer: UIColor = UIColor(red: 83/255, green: 215/255, blue: 105/255, alpha: 1) {
        didSet {
            configContainerOn()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var onBorderColorContainer: UIColor = UIColor.clear {
        didSet {
            configContainerOn()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var offBallSize: CGFloat = 0 {
        didSet {
            configBallOff()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var offBallColor: UIColor = UIColor.white {
        didSet {
            configBallOff()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var offColorContainer: UIColor = UIColor.white {
        didSet {
            configContainerOff()
            setToCurrentState()
        }
    }
    
    @IBInspectable public var offBorderColorContainer: UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            configContainerOff()
            setToCurrentState()
        }
    }
    
    //MARK: - INIT
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configView()
    }
    
    //MARK: - CONFIG
    
    private func configView() {
        
        backgroundColor = .clear
        
        let defaultBorderWidth = min(frame.width, frame.height)/20
        
        onBallSize = bounds.height - 2*defaultBorderWidth
        offBallSize = bounds.height - 2*defaultBorderWidth
        
        setToCurrentState()
        configAnimate()
        
        container.clipsToBounds = true
        
        ball.layer.shadowColor = UIColor.black.cgColor
        ball.layer.shadowOffset = CGSize(width: 0, height: 4)
        ball.layer.shadowRadius = 3
        ball.layer.shadowOpacity = 0.3
        ball.layer.masksToBounds = false
        
        addSubview(container)
        addSubview(ball)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    private func configAnimate() {
        
        ballAnimates.animations = [ballXPosAnimate, ballSizeAnimate, ballCornerRadiusAnimate, ballBGColorAniamte]
        ballAnimates.duration = 0.2
        ballAnimates.isRemovedOnCompletion = false
        ballAnimates.fillMode = kCAFillModeForwards
        ballAnimates.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        containerAnimates.animations = [containerBGColorAniamte, containerBorderColorAnimate]
        containerAnimates.duration = 0.2
        containerAnimates.isRemovedOnCompletion = false
        containerAnimates.fillMode = kCAFillModeForwards
        containerAnimates.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    }
    
    private func configBallOn() {
        
        let ballPointOn = CGPoint(x: bounds.maxX - (bounds.height + onBallSize)/2, y: (bounds.height - onBallSize)/2)
        
        ballOnFrame = CGRect(origin: ballPointOn, size: CGSize(width: onBallSize, height: onBallSize))
        ball.frame = ballOnFrame
        ball.backgroundColor = onBallColor
        ball.layer.cornerRadius = min(ball.frame.width, ball.frame.height)/2
        layoutIfNeeded()
    }
    
    private func configBallOff() {
        
        let ballPointOff = CGPoint(x: (bounds.height - offBallSize)/2, y: (bounds.height - offBallSize)/2)
        ballOffFrame = CGRect(origin: ballPointOff, size: CGSize(width: offBallSize, height: offBallSize))
        
        ball.frame = ballOffFrame
        ball.backgroundColor = offBallColor
        ball.layer.cornerRadius = min(ball.frame.width, ball.frame.height)/2
        layoutIfNeeded()
    }
    
    private func configContainerOn() {
        
        container.frame = bounds
        container.backgroundColor = onColorContainer
        container.layer.borderWidth = min(frame.width, frame.height)/20
        container.layer.borderColor = onBorderColorContainer.cgColor
        container.layer.cornerRadius = min(container.frame.width, container.frame.height)/2
        layoutIfNeeded()
    }
    
    private func configContainerOff() {
        
        container.frame = bounds
        container.backgroundColor = offColorContainer
        container.layer.borderWidth = min(frame.width, frame.height)/20
        container.layer.borderColor = offBorderColorContainer.cgColor
        container.layer.cornerRadius = min(container.frame.width, container.frame.height)/2
        layoutIfNeeded()
    }
    
    private func configBallAnimate(fromX: CGFloat, toX: CGFloat, fromSize: CGSize, toSize: CGSize, fromCornerRadius: CGFloat, toCornerRadius: CGFloat, fromBGColor: UIColor, toBGColor: UIColor) {
        
        ballXPosAnimate.fromValue = fromX
        ballXPosAnimate.toValue = toX
        
        ballSizeAnimate.fromValue = fromSize
        ballSizeAnimate.toValue = toSize
        
        ballCornerRadiusAnimate.fromValue = fromCornerRadius
        ballCornerRadiusAnimate.toValue = toCornerRadius
        
        ballBGColorAniamte.fromValue = fromBGColor.cgColor
        ballBGColorAniamte.toValue = toBGColor.cgColor
        
        ball.layer.add(ballAnimates, forKey: "HTSwitchBallAnimate")
    }
    
    private func configContainerAnimate(fromBGColor: UIColor, toBGColor: UIColor, fromBorderColor: UIColor, toBorderColor: UIColor) {
        
        containerBGColorAniamte.fromValue = fromBGColor.cgColor
        containerBGColorAniamte.toValue = toBGColor.cgColor
        
        containerBorderColorAnimate.fromValue = fromBorderColor.cgColor
        containerBorderColorAnimate.toValue = toBorderColor.cgColor
        
        container.layer.add(containerAnimates, forKey: "HTSwitchContainerAnimate")
    }
    
    //MARK: - ACTIONS
    
    @objc func onTap() {
        
        if isOn {
            setOff()
        } else {
            setOn()
        }
        
        isOn = !isOn
        
        delegate?.valueChanged(sender: self)
    }
    
    private func setToCurrentState() {
        
        if isOn {
            configBallOn()
            configContainerOn()
        } else {
            configBallOff()
            configContainerOff()
        }
    }
    
    public func setOn(isAnimate: Bool? = true) {
        
        if isAnimate! {
            
            configBallAnimate(fromX: ballOffFrame.origin.x + ballOffFrame.height/2,
                              toX: ballOnFrame.origin.x + ballOnFrame.height/2,
                              fromSize: ballOffFrame.size,
                              toSize: ballOnFrame.size,
                              fromCornerRadius: min(ballOffFrame.width, ballOffFrame.height)/2,
                              toCornerRadius: min(ballOnFrame.width, ballOnFrame.height)/2,
                              fromBGColor: offBallColor,
                              toBGColor: onBallColor)
            
            configContainerAnimate(fromBGColor: offColorContainer,
                                   toBGColor: onColorContainer,
                                   fromBorderColor: offBorderColorContainer,
                                   toBorderColor: onBorderColorContainer)
        } else {
            configBallOn()
            configContainerOn()
        }
    }
    
    public func setOff(isAnimate: Bool? = true) {
        
        if isAnimate! {
            
            configBallAnimate(fromX: ballOnFrame.origin.x + ballOnFrame.height/2,
                              toX: ballOffFrame.origin.x + ballOffFrame.height/2,
                              fromSize: ballOnFrame.size,
                              toSize: ballOffFrame.size,
                              fromCornerRadius: min(ballOnFrame.width, ballOnFrame.height)/2,
                              toCornerRadius: min(ballOffFrame.width, ballOffFrame.height)/2, fromBGColor: onBallColor,
                              toBGColor: offBallColor)
            
            configContainerAnimate(fromBGColor: onColorContainer,
                                   toBGColor: offColorContainer,
                                   fromBorderColor: onBorderColorContainer,
                                   toBorderColor: offBorderColorContainer)
        } else {
            configBallOff()
            configContainerOff()
        }
    }
}






