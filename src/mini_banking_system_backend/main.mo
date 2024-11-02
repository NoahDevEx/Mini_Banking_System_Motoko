//Mini Banking System

import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";

actor {
let pinBuffer = Buffer.Buffer<Nat>(100);
pinBuffer.add(100000);
var setPin : Nat = 0000;
var accountBalance = pinBuffer.get(0);
var notification : Text = "";
var isSuccessful : Bool = false;
var counter : Int = 0;

type Buffer = Nat;
type AccountBalance = Nat;
type counterReturn = Int;
type Pin = Nat;
type Time = {
receipt : Time.Time;
};

var Receipt : Time = {
receipt = Time.now();
};


public query func createTransPin(pin : Nat) : async Buffer {
pinBuffer.add(pin);
setPin := pin;
isSuccessful := true;
counter += 1;
return setPin;
};



//Function  to Deposit funds
public query func depositFund(amount : Nat) : async Text {
accountBalance += amount;
notification := "New current balance : NGN" #Nat.toText(accountBalance);
isSuccessful := true;
counter += 1;
return notification;
};


//Transfer funds to another recepient
public query func transferFund(amount : Nat, recepientAcc: Text, pin : Pin) : async Text {
if (setPin == pin){
if(accountBalance > amount){
accountBalance -= amount;
notification := "Transfer to:" #recepientAcc# "New current balance : NGN" #Nat.toText(accountBalance);
isSuccessful := true;
counter += 1;
return notification;
} else {
  notification := "Insufficient Fund!";
  return notification;
};
} else{
  notification := "Incorrect Pin";
  return notification;
};
};


//Withdrawal Function
public query func withdrawFund(amount : Nat) : async Text {
if (amount > accountBalance){
notification := "Insufficient Fund!";
return notification;
} else {
accountBalance -= amount;
notification := "New current balance : NGN" #Nat.toText(accountBalance);
isSuccessful := true;
counter += 1;
return notification;
};
};

public query func getTotalSuccessfulTras() : async counterReturn{
return counter;
};

public query func getTransactionnReceipt() : async Time{
return Receipt;
}

};
