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

        // Basic test
        doSomething()

        // 취약점 테스트 모음
        vulnerableHardcodedCredentials()
        vulnerableUnvalidatedInput(userInput: "'; DROP TABLE users; --")
        vulnerableDataExposure()
        vulnerableCommandInjection(userInput: "ls")
        vulnerableInsecureNetworkRequest()
        vulnerableWeakCrypto()
        vulnerableUnencryptedLocalStorage()
        vulnerableOpenRedirect(userInput: "http://malicious.com")
        vulnerableDebugPrintSensitive()
        vulnerableOutOfBoundsAccess()
    }

    func doSomething() {
        print("do some algorithm and computation")
    }

    // 1. 하드코딩된 자격 증명
    func vulnerableHardcodedCredentials() {
        let username = "root"
        let password = "root1234"
        print("Using credentials: \(username)/\(password)")
    }

    // 2. 입력값 검증 없음 (Injection)
    func vulnerableUnvalidatedInput(userInput: String) {
        let query = "SELECT * FROM users WHERE name = '\(userInput)'"
        print("Query: \(query)")
    }

    // 3. 민감 정보 로그 노출
    func vulnerableDataExposure() {
        let creditCard = "4111-1111-1111-1111"
        print("Credit Card: \(creditCard)")
    }

    // 4. 커맨드 인젝션
    func vulnerableCommandInjection(userInput: String) {
        let command = "echo \(userInput)"
        print("Executing: \(command)")
        // 실제 system() 호출은 주석 처리
    }

    // 5. HTTPS 안 쓰는 네트워크 요청 (Insecure Transport)
    func vulnerableInsecureNetworkRequest() {
        if let url = URL(string: "http://example.com/api/data") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print("Response: \(data)")
                }
            }
            task.resume()
        }
    }

    // 6. 약한 암호화 사용
    func vulnerableWeakCrypto() {
        let plaintext = "SecretData"
        let base64 = Data(plaintext.utf8).base64EncodedString()
        print("Weak encoded data (base64, not encryption!): \(base64)")
    }

    // 7. 로컬 저장소에 평문 저장
    func vulnerableUnencryptedLocalStorage() {
        let sensitiveInfo = "This is super secret"
        let fileName = "secret.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            do {
                try sensitiveInfo.write(to: fileURL, atomically: true, encoding: .utf8)
                print("Saved sensitive info to: \(fileURL)")
            } catch {
                print("Error saving file")
            }
        }
    }

    // 8. Open Redirect
    func vulnerableOpenRedirect(userInput: String) {
        // 사용자가 입력한 URL로 강제 이동 (검증 없음)
        if let url = URL(string: userInput) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    // 9. 디버그용 민감 데이터 출력
    func vulnerableDebugPrintSensitive() {
        let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
        debugPrint("DEBUG: JWT Token: \(jwt)")
    }

    // 10. Out-of-Bounds 접근
    func vulnerableOutOfBoundsAccess() {
        let arr = [1, 2, 3]
        let _ = arr[5] // Index out of range crash
    }
}
