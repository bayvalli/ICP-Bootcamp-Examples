// Calculator 

actor calculator {
  var state: Int = 0;
  
  public func add(number : Int) : async Int {
    state += number;
    state
  };

  public func substract(number : Int) : async Int {
    state -= number;
    state
  };

  public func multiply(number : Int) : async Int {
    state *= number;
    state
  };

  // division by 0 is undefined
  public func division(number : Int) : async ?Int {
    if (number == 0) {
      null
    } 
    else {
      state /= number;
      ?state
    };
  };

  public func clear() : async () {
    state := 0;
  };
};
