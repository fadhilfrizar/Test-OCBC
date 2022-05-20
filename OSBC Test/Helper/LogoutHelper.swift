//
//  LogoutHelper.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import UIKit

class LogoutHelper {
    static let shared = LogoutHelper()
    func logoutCredentials() {
        let keysToRemove = [
            Const.PREF_ACCESS_TOKEN,
            Const.PREF_ACCOUNT_NO,
            Const.PREF_USERNAME,
        ]

        for key in keysToRemove {
            UserDefaults.standard.set("", forKey: key)
        }
        
        UserDefaults.standard.set("", forKey: Const.PREF_ACCESS_TOKEN)
        UserDefaults.standard.set("", forKey: Const.PREF_ACCOUNT_NO)
        UserDefaults.standard.set("", forKey: Const.PREF_USERNAME)

        UserDefaults.standard.synchronize()

    }
}
