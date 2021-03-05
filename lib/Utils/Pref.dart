

import 'package:shared_preferences/shared_preferences.dart';

class pref{

  Future setString ({String prefId,String Value}) async {
    SharedPreferences _pr = await  SharedPreferences.getInstance();
  }

}