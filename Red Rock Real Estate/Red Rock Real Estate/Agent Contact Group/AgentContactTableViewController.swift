//
//  AgentContactTableViewController.swift
//  Red Rock Real Estate

import UIKit

class AgentContactTableViewController: UITableViewController {
    
    var contacts = [AgentContactData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "agentContactList", ofType: ".json"){
            
            //Create Url
            let url = URL(fileURLWithPath: path)
            
            do {
                //Create data object
                //file is in binary inside data
                let data = try Data.init(contentsOf: url)
                
                //create json object from data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                Parse(jsonObject: jsonObj)
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? AgentContactTableViewCell
        else {
            return tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        }
        
        // Configure the cell...
        let currentContact = contacts[indexPath.row]
        
        cell.nameOutlet.text = currentContact.name
        cell.officeOutlet.text = currentContact.office
        cell.phoneOutlet.text = currentContact.phone
        cell.emailOutlet.text = currentContact.email
        if currentContact.photo == nil {
            cell.contactImageView.image = UIImage(named: "imageNotFound")
        }
        else {
            cell.contactImageView.image = currentContact.photo
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number = contacts[indexPath.row].phone.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
        let number2 = number.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
        let number3 = number2.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
        let number4 = number3.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        print(number4)
        
        let alert = UIAlertController(title: "Call \(contacts[indexPath.row].name)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { _ in
            self.callNumber(phoneNumber: number4)
        }))
        self.present(alert, animated: true, completion: nil)
        
//        callNumber(phoneNumber: number4)
    }
    
    private func callNumber(phoneNumber:String) {
      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
    
    //MARK: - JSON Parsing
    func Parse(jsonObject: [Any]?) {
        
        guard let json = jsonObject
        else {print("Parse failed to unwrap the optional"); return }
        //De-Serialize data object
        //Loop through items
        for firstLevelItem in json {
            
            //Try to convert FLO into [String: Any]
            guard let js = firstLevelItem as? [String: Any],
                  let name = js["NAME"] as? String,
                  let office = js["OFFICE"] as? String,
                  let phone = js["PHONE #"] as? String,
                  let email = js["EMAIL"] as? String
            else {
                return
            }
            let photo = js["DISPLAY PHOTO"] as? String
            
            //Map Object
            self.contacts.append(AgentContactData(name: name, thumbnail: photo ?? "", office: office, phone: phone, email: email))
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
