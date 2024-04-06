import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totalx/Ui/Adduser.dart';

import 'custom/Iconbutton.dart';
import 'custom/search_view.dart';
// void main(){
//   runApp(MaterialApp(home: Home(),));
// }

enum SingingCharacter { All, Ageelder,Ageyounger }

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get searchController => null;
  SingingCharacter? _character = SingingCharacter.All;
  late CollectionReference _userCollection;

@override
  void initState() {
  _userCollection=FirebaseFirestore.instance.collection('user');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(backgroundColor: Colors.grey,
     appBar: AppBar(backgroundColor: Colors.black,
       leading: Icon(Icons.location_on,color: Colors.white,),
       title: Text('Nilambur',style: TextStyle(color: Colors.white),),
     ),
     body: ListView(
       children: [

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: Column(
               children: [
                 Row(
                   children: [
                     Expanded(
                       child: CustomSearchView(
                         prefix: Icon(Icons.search_outlined,color: Colors.grey,),
                         controller: searchController,
                         hintText: "search by name",
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(
                         left: 8,
                         top: 6,
                         bottom: 6,
                       ),
                       child: ClipRRect(borderRadius: BorderRadius.circular(10),
                         child: CustomIconButton(
                           height: 32,
                           width: 32,

                           onTap: () {
                           showDialog(context: context, builder: (context){
                             return AlertDialog(
                               content: Column(
                                 children: <Widget>[
                                   Align(alignment: Alignment.centerLeft,
                                     child: Padding(
                                       padding: const EdgeInsets.only(left:8),
                                       child: Text('Sort',style: TextStyle(fontWeight: FontWeight.bold),),
                                     ),
                                   ),
                                   ListTile(
                                     title: const Text('All'),
                                     leading: Radio<SingingCharacter>(
                                       value: SingingCharacter.All,
                                       groupValue: _character,
                                       onChanged: (SingingCharacter? value) {
                                         setState(() {
                                           _character = value;
                                         });
                                       },
                                     ),
                                   ),
                                   ListTile(
                                     title: const Text('Age:Elder'),
                                     leading: Radio<SingingCharacter>(
                                       value: SingingCharacter.Ageelder,
                                       groupValue: _character,
                                       onChanged: (SingingCharacter? value) {
                                         setState(() {
                                           _character = value;
                                         });
                                       },
                                     ),
                                   ),
                                   ListTile(
                                     title: const Text('Age:Younger'),
                                     leading: Radio<SingingCharacter>(
                                       value: SingingCharacter.Ageyounger,
                                       groupValue: _character,
                                       onChanged: (SingingCharacter? value) {
                                         setState(() {
                                           _character = value;
                                         });
                                       },
                                     ),
                                   ),
                                 ],
                               ),
                             );
                           });
                           },
                           color: Colors.black,
                           child: Icon(CupertinoIcons.line_horizontal_3_decrease,color: Colors.white,),

                         ),
                       ),
                     )
                   ],
                 ),
               ],
             ),
           ),
         ),
         StreamBuilder<QuerySnapshot>(stream: getUser(), builder:(context,snapshot){
           if(snapshot.hasError){
             return Text('Error${snapshot.error}');
           }
           if(snapshot.connectionState==ConnectionState.waiting){
             return CircularProgressIndicator();
           }
           final users=snapshot.data!.docs;
           return Expanded(child: ListView.separated(itemCount: users.length,itemBuilder: (context,index){
             final user=users[index];
             final userId=user.id;
             final userName=user['name'];
             final userAge=user['age'];
             return Card(color: Colors.white,
               child: ListTile(
                 title: Text('$userName',style: TextStyle(fontSize: 15),),
                 subtitle: Text('$userAge',style: TextStyle(fontSize: 10),),
                 trailing: IconButton(onPressed: () {
                   deleteUser(userId);
                 }, icon: Icon(CupertinoIcons.delete),),
               ),
             );
           }, separatorBuilder: (BuildContext context, int index) {
             return Divider(
               thickness: 10,
               color: Colors.transparent,
             );
           },));
         } )
       ],
     ),
     floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,
       child: Icon(Icons.add,color: Colors.white,),
       onPressed: () {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Adduser()));
       },),
   );
  }
  Stream<QuerySnapshot> getUser(){
    return _userCollection.snapshots();
  }
///delete user
Future<void>deleteUser(var id)async{
  return _userCollection.doc(id).delete().then((value) {
    print('user delete Successfuly');
  }).catchError((error){
    print('user delet failed$error');
  });
}
}