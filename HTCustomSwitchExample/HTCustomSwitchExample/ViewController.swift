//
//  ViewController.swift
//  HTCustomSwitchExample
//
//  Created by UltraHigh on 10/15/18.
//  Copyright © 2018 HT. All rights reserved.
//

import UIKit
import HTCustomSwitch

class ViewController: UIViewController {
    
    //MARK: - OUTLET
    @IBOutlet weak var htCustomSwitch: HTCustomSwitch!
    
    @IBOutlet weak var txfOnBallSize: UITextField!
    @IBOutlet weak var txfOnBallR: UITextField!
    @IBOutlet weak var txfOnBallG: UITextField!
    @IBOutlet weak var txfOnBallB: UITextField!
    @IBOutlet weak var txfOnBallBorderR: UITextField!
    @IBOutlet weak var txfOnBallBorderG: UITextField!
    @IBOutlet weak var txfOnBallBorderB: UITextField!
    @IBOutlet weak var txfOnR: UITextField!
    @IBOutlet weak var txfOnG: UITextField!
    @IBOutlet weak var txfOnB: UITextField!
    @IBOutlet weak var txfOnBorderR: UITextField!
    @IBOutlet weak var txfOnBorderG: UITextField!
    @IBOutlet weak var txfOnBorderB: UITextField!
    
    //
    
    @IBOutlet weak var txfOffBallSize: UITextField!
    @IBOutlet weak var txfOffBallR: UITextField!
    @IBOutlet weak var txfOffBallG: UITextField!
    @IBOutlet weak var txfOffBallB: UITextField!
    @IBOutlet weak var txfOffBallBorderR: UITextField!
    @IBOutlet weak var txfOffBallBorderG: UITextField!
    @IBOutlet weak var txfOffBallBorderB: UITextField!
    @IBOutlet weak var txfOffR: UITextField!
    @IBOutlet weak var txfOffG: UITextField!
    @IBOutlet weak var txfOffB: UITextField!
    @IBOutlet weak var txfOffBorderR: UITextField!
    @IBOutlet weak var txfOffBorderG: UITextField!
    @IBOutlet weak var txfOffBorderB: UITextField!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    //MARK: - LIVE CIRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        keyboardObserver()
    }
}

//MARK: - SUPPORT FUNCTIONS
extension ViewController {
    
    private func configView() {
        
        htCustomSwitch.delegate = self
        
        txfOnBallSize.delegate = self
        txfOnBallR.delegate = self
        txfOnBallG.delegate = self
        txfOnBallB.delegate = self
        txfOnBallBorderR.delegate = self
        txfOnBallBorderG.delegate = self
        txfOnBallBorderB.delegate = self
        txfOnR.delegate = self
        txfOnG.delegate = self
        txfOnB.delegate = self
        txfOnBorderR.delegate = self
        txfOnBorderG.delegate = self
        txfOnBorderB.delegate = self
        
        txfOffBallSize.delegate = self
        txfOffBallR.delegate = self
        txfOffBallG.delegate = self
        txfOffBallB.delegate = self
        txfOffBallBorderR.delegate = self
        txfOffBallBorderG.delegate = self
        txfOffBallBorderB.delegate = self
        txfOffR.delegate = self
        txfOffG.delegate = self
        txfOffB.delegate = self
        txfOffBorderR.delegate = self
        txfOffBorderG.delegate = self
        txfOffBorderB.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func keyboardObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardDidShown(_ notification: Notification){
        
        guard let userInfo = notification.userInfo, let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrameValue.cgRectValue.size.height
        bottomConstraint.constant += keyboardHeight
    }
    
    @objc private func keyboardWillHide(_ notification: Notification){
        
        bottomConstraint.constant = 20
    }
}

//MARK: - Textfeild delegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text != "" else { return }
        
        switch textField {
            
        case txfOnBallSize:
            htCustomSwitch.onBallSize = CGFloat(Double(txfOnBallSize.text ?? "0") ?? 0)
            
        case txfOnBallR, txfOnBallG, txfOnBallB:
            htCustomSwitch.onBallColor = UIColor(red: CGFloat(Double(txfOnBallR.text ?? "0") ?? 0),
                                                   green: CGFloat(Double(txfOnBallG.text ?? "0") ?? 0),
                                                   blue: CGFloat(Double(txfOnBallB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOnBallBorderR, txfOnBallBorderG, txfOnBallBorderB:
            htCustomSwitch.onBallBorderColor = UIColor(red: CGFloat(Double(txfOnBallBorderR.text ?? "0") ?? 0),
                                                 green: CGFloat(Double(txfOnBallBorderG.text ?? "0") ?? 0),
                                                 blue: CGFloat(Double(txfOnBallBorderB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOnR, txfOnG, txfOnB:
            htCustomSwitch.onColorContainer = UIColor(red: CGFloat(Double(txfOnR.text ?? "0") ?? 0),
                                                        green: CGFloat(Double(txfOnG.text ?? "0") ?? 0),
                                                        blue: CGFloat(Double(txfOnB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOnBorderR, txfOnBorderG, txfOnBorderB:
            htCustomSwitch.onBorderColorContainer = UIColor(red: CGFloat(Double(txfOnBorderR.text ?? "0") ?? 0),
                                                              green: CGFloat(Double(txfOnBorderG.text ?? "0") ?? 0),
                                                              blue: CGFloat(Double(txfOnBorderB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOffBallSize:
            htCustomSwitch.offBallSize = CGFloat(Double(txfOffBallSize.text ?? "0") ?? 0)
            
        case txfOffBallR, txfOffBallG, txfOffBallB:
            htCustomSwitch.offBallColor = UIColor(red: CGFloat(Double(txfOffBallR.text ?? "0") ?? 0),
                                                    green: CGFloat(Double(txfOffBallG.text ?? "0") ?? 0),
                                                    blue: CGFloat(Double(txfOffBallB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOffBallBorderR, txfOffBallBorderG, txfOffBallBorderB:
            htCustomSwitch.offBallBorderColor = UIColor(red: CGFloat(Double(txfOffBallBorderR.text ?? "0") ?? 0),
                                                        green: CGFloat(Double(txfOffBallBorderG.text ?? "0") ?? 0),
                                                        blue: CGFloat(Double(txfOffBallBorderB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOffR, txfOffG, txfOffB:
            htCustomSwitch.offColorContainer = UIColor(red: CGFloat(Double(txfOffR.text ?? "0") ?? 0),
                                                         green: CGFloat(Double(txfOffG.text ?? "0") ?? 0),
                                                         blue: CGFloat(Double(txfOffB.text ?? "0") ?? 0), alpha: 1)
            
        case txfOffBorderR, txfOffBorderG, txfOffBorderB:
            htCustomSwitch.offBorderColorContainer = UIColor(red: CGFloat(Double(txfOffBorderR.text ?? "0") ?? 0),
                                                               green: CGFloat(Double(txfOffBorderG.text ?? "0") ?? 0),
                                                               blue: CGFloat(Double(txfOffBorderB.text ?? "0") ?? 0), alpha: 1)
        default:
            break
        }
    }
}

//MARK: - htCustomSwitch Delegate
extension ViewController: HTCustomSwitchDelegate {
    
    func valueChanged(sender: HTCustomSwitch) {
        print(sender.isOn)
    }
}









