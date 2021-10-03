//
//  SearchTabViewController.swift
//  Red Rock Real Estate


import UIKit

class SearchTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    //Empty array of swift users
    var houseData = [HouseData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialParse()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        houseData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell", for: indexPath) as! HouseTableViewCell
        
        let currentHouse = houseData[indexPath.row]
        //Configure cell.
        cell.bed.text = "Beds: \(String(currentHouse.beds))"
        cell.bath.text = "Baths: \(String(currentHouse.baths))"
        cell.garage.text = "Garage: \(String(currentHouse.garage))"
        cell.address.text = "Address: \(currentHouse.address)"
        cell.lotSqft.text = "Lot sqft: \(String(currentHouse.lotSqft))"
        cell.sqft.text = "sqft: \(String(currentHouse.sqft))"
        cell.listPrice.text = "Listing price: \(String(currentHouse.listPrice))"
        cell.stories.text = "Stories: \(String(currentHouse.stories))"
        
        return cell
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
    }
    
    //method to download/parse json data from url
    func initialParse() {
        
        let headers = [
            "x-rapidapi-host": "us-real-estate.p.rapidapi.com",
            "x-rapidapi-key": "327ced727emshb206dc82710f018p165aadjsn1ed5015f00e0"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://us-real-estate.p.rapidapi.com/v2/for-sale?offset=0&limit=42&state_code=UT&city=Washington&sort=newest")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (opt_data, opt_response, opt_error) in
            let re = opt_response as? HTTPURLResponse
            print(re!.statusCode)
            //error check/bail-out
            if opt_error != nil
            { return }
            
            //check response
            guard let response = opt_response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = opt_data
            else { return }
            
            do {
                //deserialize data object
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //parse data
                    let secondLevelItem = json["data"] as? [String: Any]
                    let homeSearch = secondLevelItem!["home_search"] as? [String: Any]
                    let results = homeSearch!["results"] as? [Dictionary<String, Any>]
                    
                    for sl in results! {
                        guard let listPrice = sl["list_price"] as? Int,
                              let description = sl["description"] as? [String: Any],
                              let lotSqft = description["lot_sqft"] as? Int,
                              let sqft = description["sqft"] as? Int,
                              let baths = description["baths"] as? Int,
                              let garage = description["garage"] as? Int,
                              let stories = description["stories"] as? Int,
                              let beds = description["beds"] as? Int,
                              let location = sl["location"] as? [String: Any],
                              let address = location["address"] as? [String: Any],
                              let postalCode = address["postal_code"] as? String,
                              let state = address["state"] as? String,
                              let city = address["city"] as? String,
                              let line = address["line"] as? String
                        else { continue }
                        let house = HouseData(listPrice: listPrice, lotSqft: lotSqft, sqft: sqft, baths: baths, garage: garage, stories: stories, beds: beds, postalCode: postalCode, state: state, city: city, line: line)
                        self.houseData.append(house)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                for i in self.houseData {
                    print(i.lotSqft)
                }
                self.tableView.reloadData()
//                self.performSegue(withIdentifier: "sources", sender: self)
            }
        })
        dataTask.resume()
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
