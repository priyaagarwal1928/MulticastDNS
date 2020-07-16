

import UIKit

class JoiningTableViewCell: UITableViewCell {

       //MARK: - IBOutlets
       @IBOutlet weak var lblserviceNm: UILabel!
       @IBOutlet weak var lblserviceType: UILabel!
       @IBOutlet weak var lblPort: UILabel!
       @IBOutlet weak var lblIPAdd: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
