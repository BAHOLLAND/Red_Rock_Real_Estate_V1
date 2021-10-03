//
//  AgentContactData.swift
//  Red Rock Real Estate


import Foundation
import UIKit

class AgentContactData {
    
    //stored properties
    var name: String
    var office: String
    var phone: String
    var email: String
    var photo: UIImage!
    
    //initializer
    init(name: String, thumbnail: String, office: String, phone: String, email: String) {
        
        self.name = name
        self.office = office
        self.phone = phone
        self.email = email
        if let url = URL(string: thumbnail) {
            
            //URL session
            let s1 = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = s1.dataTask(with: url, completionHandler:  { (data, response, error)in
                Thread.sleep(forTimeInterval: 1)
                
                if error != nil {return}
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = data
                else {return}
                
                self.photo = UIImage(data: data)
            })
            
            task.resume()
        }
    }
}
