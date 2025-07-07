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
        
        vulnerableHardcodedCredentials()
        vulnerableUnvalidatedInput(userInput: "DROP TABLE users;")
        vulnerableDataExposure()
        vulnerableCommandInjection(userInput: "ls")
    }
    
    func doSomething() {
        print("do some algorithm and computation")
    }

    // 1. 하드코딩된 자격 증명 (Hardcoded Credentials)
    func vulnerableHardcodedCredentials() {
        let username = "admin"
        let password = "password123" // ❌ 실제 앱에 이런 하드코딩은 취약함
        print("Using credentials: \(username)/\(password)")
    }

    // 2. 입력값 검증 없음 (Injection 가능)
    func vulnerableUnvalidatedInput(userInput: String) {
        // 예: SQL Injection 공격 가능 (가정)
        let query = "SELECT * FROM users WHERE name = '\(userInput)'"
        print("Query: \(query)") // ❌ 실제 DB 쿼리에 넣으면 위험
    }

    // 3. 민감 정보 로그 노출
    func vulnerableDataExposure() {
        let ssn = "123-45-6789" // ❌ 민감 정보
        print("SSN: \(ssn)") // 로그에 노출되면 위험
    }

    // 4. 커맨드 인젝션 시뮬레이션
    func vulnerableCommandInjection(userInput: String) {
        let command = "echo \(userInput)"
        print("Executing: \(command)")
        // 실제 실행은 주석 처리
        // system(command) 또는 Process() 등으로 실행 가능
    }
}
