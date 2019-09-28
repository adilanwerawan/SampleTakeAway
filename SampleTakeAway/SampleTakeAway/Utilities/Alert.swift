//
//  Alert.swift
//  RestaurantsApp
//
//  Created by Adil Anwer on 5/18/18.
//  Copyright © 2018 Adil Anwer. All rights reserved.
//

import UIKit

public class Alert {
    
    private init() {
        
    }
    
    public static func showMsg(title: String = "Notification", msg: String , btnActionTitle: String? = "Okay" ) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (_) in
            
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithCompletion(title: String = "Notification", msg: String , btnActionTitle: String? = "Okay" , completionAction: @escaping () -> Void ) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (_) in
            
            completionAction()
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithTwoActions(title: String , msg: String , okBtnTitle: String , okBtnAction: @escaping () -> Void , cancelBtnTitle: String , cancelBtnAction: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { (_) in
            
            okBtnAction()
        })
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (_) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        alertController .addAction(cancelAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithThreeActionsWithParentVC(_ parentVC: UIViewController , title: String , msg: String , FirstBtnTitle: String , FirstBtnAction: @escaping () -> Void , SecondBtnTitle: String , SecondBtnAction: @escaping () -> Void , cancelBtnTitle: String , cancelBtnAction: @escaping () -> Void ) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let firstBtnAction = UIAlertAction(title: FirstBtnTitle, style: .default, handler: { (_) in
            
            FirstBtnAction()
        })
        
        let secondBtnAction = UIAlertAction(title: SecondBtnTitle, style: .default, handler: { (_) in
            
            SecondBtnAction()
        })
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (_) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(firstBtnAction)
        alertController .addAction(secondBtnAction)
        alertController .addAction(cancelAction)
        
        parentVC.present(alertController, animated: true, completion: nil)
        
        //        Alert.showOnWindow(alertController)
        
    }
    
    private static func showOnWindow(_ alert: UIAlertController) {
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
}
