import UIKit
import Alamofire
import SwiftyJSON
import GoogleSignIn

override func viewDidLoad() {
    super.viewDidLoad()
    
    let googleSignInButton = GIDSignInButton()
    googleSignInButton.center = view.center
    view.addSubview(googleSignInButton)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]

        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        AF.request("https://dummyjson.com/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let token = json["token"].stringValue
                UserDefaults.standard.set(token, forKey: "userToken")
                self.performSegue(withIdentifier: "goToMyAccount", sender: self)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
