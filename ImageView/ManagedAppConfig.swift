//
//  managed-app-config.swift
//
//  Created by James Felton on 2/7/17.
/* Copyright (c) 2017 JAMF Software
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation

public class ManagedAppConfig {
    
    enum DictionaryType {
        case AppConfig
        case Feedback
    }
    
    // singleton
    public static let shared = ManagedAppConfig()
    
    private let kFeedbackKey = "com.apple.feedback.managed"
    private let kConfigurationKey = "com.apple.configuration.managed"
    
    private var configHooks = [([String:Any?]) -> Void]()
    private var feedbackHooks = [([String:Any?]) -> Void]()
    
    init() {
        // add observer
        NotificationCenter.default.addObserver(self, selector: #selector(ManagedAppConfig.didChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    // instead of modifying this file's didChange event, allow the registration of closures
    public func addAppConfigChangedHook(_ appConfigChangedHook: @escaping ([String:Any?]) -> Void) {
        configHooks.append(appConfigChangedHook)
    }
    
    // called when the userdefaults did change notification fires
    @objc func didChange() {
        if let configDict = UserDefaults.standard.dictionary(forKey: kConfigurationKey) {
            for hook in configHooks {
                hook(configDict)
            }
        }
        if let feedbackDict = UserDefaults.standard.dictionary(forKey: kFeedbackKey) {
            for hook in feedbackHooks {
                hook(feedbackDict)
            }
        }
    }
    
    // MARK - Dictionary getters/setters
    public func getConfigValue(forKey: String) -> Any? {
        if let myAppConfig = UserDefaults.standard.dictionary(forKey: kConfigurationKey) {
            return myAppConfig[forKey]
        }
        return nil
    }
    
    public func getFeedbackValue(forKey: String) -> Any? {
        if var myAppConfigFeedback = UserDefaults.standard.dictionary(forKey: kFeedbackKey) {
            return myAppConfigFeedback[forKey]
        }
        return nil
    }
    
    public func updateValue(_ value: Any, forKey: String) {
        if var myAppConfigFeedback = UserDefaults.standard.dictionary(forKey: kFeedbackKey) {
            myAppConfigFeedback[forKey] = value
            UserDefaults.standard.set(myAppConfigFeedback, forKey: kFeedbackKey)
        } else {
            // there was no dictionary at all, create one and place the key/value pair in it
            let feedbackDict = [forKey: value]
            UserDefaults.standard.set(feedbackDict, forKey: kFeedbackKey)
        }
    }
    
    
    
}
