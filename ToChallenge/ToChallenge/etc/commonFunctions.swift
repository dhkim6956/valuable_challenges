import UIKit


//텍스트끝에 SF Symbol 색상입혀서 넣어주는 함수, 텍스트 없을시 (nil) SF Symbol 만 반환, .attributedText 로 삽입
func insertSymbol(textString: String?, symbolName: String, symbolColor: UIColor) -> NSMutableAttributedString {
    
    let imageAttachment = NSTextAttachment()
    
    imageAttachment.image = UIImage(systemName: symbolName)!.withTintColor(symbolColor)
    
    if let haveText = textString {
        let fullString = NSMutableAttributedString(string: haveText)
        fullString.append(NSMutableAttributedString(string: " "))
        fullString.append(NSAttributedString(attachment: imageAttachment))
        return fullString
    } else {
        return NSMutableAttributedString(attachment: imageAttachment)
    }
}

//투명도 0 UIColor 랜덤 색상 반환
func getRandomColor() -> UIColor{
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
        
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}
