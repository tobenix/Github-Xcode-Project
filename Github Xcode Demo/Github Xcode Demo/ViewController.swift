//
//  ViewController.swift
//  Github Xcode Demo
//
//  Created by Paul Solt on 3/2/16.
//  Copyright © 2016 Super Easy Apps LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello!")

        // Added 1st statement on Branch Update-the-UI

        doSomething()

        vulnerableHardcodedPassword()
        vulnerableURLSession()
        vulnerableSQLInjection()
        vulnerableInsecureRandom()
    }

    func doSomething() {
        print("do some algorithm and computation")
    }

    /// 취약점 1: 하드코딩된 비밀번호
    func vulnerableHardcodedPassword() {
        let password = "SuperSecret123!"  // [HARD-CODED PASSWORD]
        print("Hardcoded password: \(password)")
    }

    /// 취약점 2: 인증서 검증 없이 URLSession 사용
    func vulnerableURLSession() {
        let url = URL(string: "https://example.com")!
        let session = URLSession(configuration: .default, delegate: InsecureSessionDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: url) { data, response, error in
            print("Insecure request made")
        }
        task.resume()
    }

    /// 취약점 3: SQL Injection 예시
    func vulnerableSQLInjection() {
        let userInput = "'; DROP TABLE users; --"
        let query = "SELECT * FROM users WHERE name = '\(userInput)'"
        print("Vulnerable SQL query: \(query)")
    }

    /// 취약점 4: 암호학적으로 안전하지 않은 랜덤값 사용
    func vulnerableInsecureRandom() {
        let randomNumber = arc4random() % 100  // [INSECURE RANDOM]
        print("Insecure random number: \(randomNumber)")
    }
}

/// 취약한 URLSessionDelegate: 인증서 검증 비활성화
class InsecureSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
