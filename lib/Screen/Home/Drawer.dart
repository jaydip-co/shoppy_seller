import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy_seller/Notifier/DrawerChangeNotifier.dart';
import 'package:shoppy_seller/Services/AuthService.dart';


class CommonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context,listen: false);
    final _drawerNotifier = Provider.of<DrawerChangeNotifier>(context,listen: false);
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 10,),
          ListTile(
            onTap: (){

            },
            leading: CircleAvatar(
              child: Image.asset('asset/Icon.jpg'),
            ),
            title: Text('Profile'),
          ),
          Divider(height: 20,thickness: 2,),
          ListTile(
            onTap: (){
              _drawerNotifier.setBody(DrawerChangeNotifier.mainDesc);
              Navigator.pop(context);
            },
            title: Text('Home'),
          ),
          ExpansionTile(
            title: Text('Categories'),
            children: [
              ListTile(
                onTap: (){},
                title: Text('Groceries'),
              ),
              ListTile(
                onTap: (){},
                title: Text('Medicines'),
              ),
              ListTile(
                onTap: (){},
                title: Text('Cosmetics'),
              ),
            ],
          ),
          ListTile(
            onTap: (){
              _drawerNotifier.setBody(DrawerChangeNotifier.orderDesc);
              Navigator.pop(context);
            },
            title: Text('Orders'),
          ),
          ListTile(
            onTap: (){
              _drawerNotifier.setBody(DrawerChangeNotifier.productDesc);
              Navigator.pop(context);
            },
            title: Text('Inventory'),
          ),
          ListTile(
            onTap: () {
              _drawerNotifier.setBody(DrawerChangeNotifier.settingDesc);
              Navigator.pop(context);
            },
            title: Text('Setting'),
          ),
          ListTile(
            onTap: (){
              _auth.SignOut();
            },
            title: Text('Log Out'),
          ),
          ListTile(
            onTap: (){},
            title: Text('About Us'),
          ),
        ],
      ),
    );
  }
}

