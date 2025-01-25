//
//  CustomAlert.swift
//  CampaignBrowser
//
//  Created by Bartłomiej Bocian on 11/09/2017.
//  Copyright © 2017 Westwing GmbH. All rights reserved.
//

import SCLAlertView

import UIKit

enum MessageType {
    case error
    case warning
    case info
}

class CustomAlert: NSObject {
    
    typealias MethodHandler = ()  -> Void
    
    func showMessage(type: MessageType,  title: String, subTitle: String, buttonTitle: String, action: @escaping MethodHandler) -> Void {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton(buttonTitle){
            action()
        }
        switch type {
        case .error:
            alertView.showError(title, subTitle: subTitle)
        case .warning:
            alertView.showWarning(title, subTitle: subTitle)
        case .info:
            alertView.showInfo(title, subTitle: subTitle)
        }
    }
}
