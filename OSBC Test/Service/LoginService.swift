//
//  LoginService.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import Foundation

class LoginService: NSObject {
    static let shared = LoginService()
    
    func login(username: String, password: String ,completion: @escaping (LoginModel?, Error?) -> ()) {
//        let urlString = "https://green-thumb-64168.uc.r.appspot.com"
        var dict = Dictionary<String, Any>()
        
        dict = ["username" :username, "password" :password]
        var  jsonData = NSData()
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) as NSData
        } catch {
            print(error.localizedDescription)
        }
        
        guard let url:URL = URL(string: "https://green-thumb-64168.uc.r.appspot.com/login") else { return }
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(jsonData.length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData as Data
        
        let task = session.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch data:", err)
                return
            }
            
            // check response
            guard let httpResponse = resp as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                print(resp?.description as Any)
                return
            }
            
            guard let data = data else { return }
            do {
                let loginModel = try JSONDecoder().decode(LoginModel.self, from: data)
                DispatchQueue.main.async {
                    completion(loginModel, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }
        task.resume()
    }
    
}
