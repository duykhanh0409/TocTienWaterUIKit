import UIKit

var greeting = "Hello, playground"


class Person {
    var name: String
    var pet: Pet?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Pet {
    var name: String
    weak var owner: Person?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


var person: Person? = Person(name: "Alice") // count = 1
var pet: Pet? = Pet(name: "Fluffykins") // count = 1

person?.pet = pet // thêm 1 strong reference đến pet, nên class pet sẽ count = 2
pet?.owner = person // vì chỉ là weak reference nên person vẫn count = 1 thui

person = nil // gán cái này bằng nil thì person mất 1 strong reference -1, total referance của person chỉ có 1, -1 nửa = 0 nên deinit lun
pet = nil // trước tiên pet = nil là count -1 đi, 2-1 còn 1 reference thui, tiếp theo person bị deinit rồi nên không còn ai giữ pet nửa, nên -1 nửa, = 0. giải phóng lun



let add: (Int, Int) -> Int = {(a,c) in
    a + c
}
