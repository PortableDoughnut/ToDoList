//
//  ThemeController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import Foundation
import UIKit

class ThemeController {
	var isDarkMode: Bool {
			get {
				UserDefaults.standard.bool(forKey: "isDarkMode")
			}
			set {
				UserDefaults.standard.set(newValue, forKey: "isDarkMode")
				NotificationCenter.default.post(name: .themeChanged, object: nil)
			}
		}
	
	func toggleTheme() {
		let newThemeValue = !UserDefaults.standard.bool(forKey: "isDarkMode")
		UserDefaults.standard.set(newThemeValue, forKey: "isDarkMode")
		
		NotificationCenter.default.post(name: .themeChanged, object: nil)
	}
}
