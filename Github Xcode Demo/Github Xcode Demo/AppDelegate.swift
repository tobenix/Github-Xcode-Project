//
//  AppDelegate.swift
//  Github Xcode Demo
//
//  Created by Paul Solt on 3/2/16.
//  Copyright © 2016 Super Easy Apps LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 🚨 1) 하드코딩된 API Key (노출)
    let apiKey = "123456-SECRET-API-KEY"

    // 🚨 2) 하드코딩된 비밀번호 (노출)
    let adminPassword = "SuperSecretPassword123"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 🚨 3) 민감 정보 로그 출력
        print("DEBUG: API Key: \(apiKey)")
        print("DEBUG: Admin password: \(adminPassword)")

        // 🚨 4) HTTPS 검증 비활성화 예시 (만약 NSURLSession 사용 시)
        if let url = URL(string: "http://example.com/api") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print("Response: \(data)")
                }
            }
            task.resume()
        }

        // 🚨 5) 안전하지 않은 UserDefaults 저장
        UserDefaults.standard.set(adminPassword, forKey: "adminPassword")

        // 🚨 6) Hardcoded JWT Token
        let jwtToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

        // 🚨 7) 강제로 크래시 유발 (예외 처리 없음)
        let numbers = [1, 2, 3]
        let _ = numbers[5] // Index out of range

        // 🚨 8) 비밀번호 평문으로 파일 저장
        savePlaintextPassword()

        return true
    }

    // 🚨 8) 평문 저장 예시
    func savePlaintextPassword() {
        let password = "plaintext-password"
        let file = "password.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                try password.write(to: fileURL, atomically: false, encoding: .utf8)
                print("Saved plaintext password to file: \(fileURL)")
            } catch {
                print("Error saving file")
            }
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // ...
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // ...
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // ...
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // ...
    }

    func applicationWillTerminate(application: UIApplication) {
        // ...
    }
}
