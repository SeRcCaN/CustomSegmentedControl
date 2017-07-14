//
//  CustomSegmentedControl.swift
//  CustomSegmentedControl
//
//  Created by Sercan Burak AĞIR on 13.07.2017.
//  Copyright © 2017 Sercan Burak AĞIR. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    
    var buttons = [UIButton]()
    var selector = UIView()
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var borderWidth: CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeperatedButtonTitles: String = ""{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var buttonTextColor: UIColor = .lightGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectedTextColor: UIColor = .white{
        didSet{
            updateView()
        }
    }
    
    func updateView(){
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(buttonTextColor, for: .normal)
            //button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(mennuButonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectedTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttons.count)
        let selectorHeight = frame.height
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: selectorHeight))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    @objc
    func mennuButonTapped(button: UIButton){
        for (buttonIndex, btn) in buttons.enumerated(){
            btn.setTitleColor(buttonTextColor, for: .normal)
            
            if btn == button{
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                
                btn.setTitleColor(selectedTextColor, for: .normal)
            }
        }
        
        sendActions(for: .valueChanged)
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    

}
