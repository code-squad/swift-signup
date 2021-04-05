
import Foundation
import UIKit

class PersonnalInformationViewController : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

