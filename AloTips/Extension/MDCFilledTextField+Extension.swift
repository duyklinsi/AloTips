//
//  MDCFilledTextField+Extension.swift
//  AloTips
//
//  Created by Admin on 8/20/21.
//

import Foundation
import UIKit
import MaterialComponents

public protocol FormInputStyle {
    var floatingLabelColorNormal: UIColor { get }
    var floatingLabelColorEditting: UIColor { get }
    var filledBackgroundColorNormal: UIColor { get }
    var filledBackgroundColorEditting: UIColor { get }
    var underlineColorNormal: UIColor { get }
    var underlineColorEditting: UIColor { get }
    var textColorNormal: UIColor { get }
    var textColorEditting: UIColor { get }
    var normalLabelColorNormal: UIColor { get }
    var normalLabelColorEditting: UIColor { get }
}

extension MDCFilledTextField: FormInputStyle {
    
    public var floatingLabelColorNormal: UIColor {
        return .white
    }
    
    public var floatingLabelColorEditting: UIColor {
        return AloTipsColor.blue_main_color.value()
    }
    
    public var filledBackgroundColorNormal: UIColor {
        return .clear
    }
    
    public var filledBackgroundColorEditting: UIColor {
        return .clear
    }
    
    public var underlineColorNormal: UIColor {
        return AloTipsColor.dark_gray_main_color.value()
    }
    
    public var underlineColorEditting: UIColor {
        return AloTipsColor.blue_main_color.value()
    }
    
    public var textColorNormal: UIColor {
        return .white
    }
    
    public var textColorEditting: UIColor {
        return .white
    }
    
    public var normalLabelColorNormal: UIColor {
        return AloTipsColor.dark_gray_main_color.value()
    }
    
    public var normalLabelColorEditting: UIColor {
        return AloTipsColor.blue_main_color.value()
    }
    
    func style() {
        setFloatingLabelColor(floatingLabelColorNormal, for: .normal)
        setFloatingLabelColor(floatingLabelColorEditting, for: .editing)
        setFilledBackgroundColor(filledBackgroundColorNormal, for: .normal)
        setFilledBackgroundColor(filledBackgroundColorEditting, for: .editing)
        setUnderlineColor(underlineColorNormal, for: .normal)
        setUnderlineColor(underlineColorEditting, for: .editing)
        setTextColor(textColorNormal, for: .normal)
        setTextColor(textColorEditting, for: .editing)
        setNormalLabelColor(normalLabelColorNormal, for: .normal)
        setNormalLabelColor(normalLabelColorEditting, for: .editing)
        leadingAssistiveLabel.font = UIFont(name: AloTipsFont.avenirNextRegular, size: 10)!
        leadingEdgePaddingOverride = 0
    }
    
    func showError(message: String?) {
        leadingAssistiveLabel.text =  message
        setLeadingAssistiveLabelColor(.red, for: .normal)
    }
}

