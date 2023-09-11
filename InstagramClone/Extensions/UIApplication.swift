//
//  UIApplication.swift
//  InstagramClone
//
//  Created by Kevin Sander Utomo on 10/09/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
