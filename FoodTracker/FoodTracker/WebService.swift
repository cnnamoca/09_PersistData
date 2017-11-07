//
//  WebService.swift
//  FoodTracker
//
//  Created by Shahin on 2017-11-06.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class WebService
{
    // MARK: - Properties
    static let shared = WebService()
    
    // MARK: - Networking
    func signup(with email: String, password: String, and presentingViewController: UIViewController)
    {
        let postData = [
            "username": email,
            "password": password
        ]
        
        guard let postJSON = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
            print("could not serialize json")
            return
        }
        let url = URL(string: "https://cloud-tracker.herokuapp.com/signup")!
        let request = NSMutableURLRequest(url: url)
        request.httpBody = postJSON
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            /*
            if let err = error
            {
                // log something meaningful... maybe even showing an alert to the user
                print(err.localizedDescription)
            }
            else
            {
                // do your happy dance or something
                
            }
            */
            
            guard let data = data else {
                print("no data returned from server \(error?.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("no response returned from server \(error)")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data returned is not json, or not valid")
                return
            }
           
            // Shahin's magic sauce
            let user = User()
            user.parse(with: json)
            
            presentingViewController.dismiss(animated: true, completion: nil)
            
            guard response.statusCode == 200 else {
                // handle error
                print("an error occurred \(json["error"])")
                return
            }
            
            
        }
        // do something with the json object
        task.resume()
    }
}
