
class validator{
  static String numbervalidtion(String value){
    Pattern pattern = '^[0-9]+';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter The Number Only';
    } else {
      return null;
    }
  }
  static String  ValidateEmail(String value){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!(regex.hasMatch(value)))
      return "Invalid Email";
  }
  static String varifyMobile(String val){
    if(val.isEmpty){
      return "Enter Mobile number";
    }
    else if(val.trim().length != 10){
      return "Enter 10 Digits";
    }
    else{
      return null;
    }
  }
  static String varifyPincode(String val){
    if(val.isEmpty){
      return "Enter Pincode";
    }
    else if(val.trim().length != 6){
      return "Enter 6 Digits";
    }
    else{
      return null;
    }
  }

}