import UIKit
import Alamofire
import SwiftyJSON

class MyAccountViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else { return }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        AF.request("https://dummyjson.com/api/user", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.nameLabel.text = json["name"].stringValue
                self.emailLabel.text = json["email"].stringValue
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
