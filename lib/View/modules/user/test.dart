
// import 'package:flutter/material.dart';

// class adddonors extends StatefulWidget {
//   const adddonors({super.key});

//   @override
//   State<adddonors> createState() => _adddonorsState();
// }

// class _adddonorsState extends State<adddonors> {

//   var selection;
//   List sampleList = [
//     's',
//     'd',

//   ];



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(223, 157, 157, 1),
//         title: Text(
//           'Add Donors',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
//         ),
//       ),
//       body: Container(

//     child: Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//     border: Border.all(color: Colors.brown, width: 1.0)),
//     padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
//     child: DropdownButtonHideUnderline(
//     child: ButtonTheme(
//     alignedDropdown: true,
//     child:DropdownButton(
//         isExpanded: true,
//         isDense: true,
//         value: selection,
//         icon: Icon(
//           Icons.arrow_drop_down,
//           color: Colors.brown,
//         ),
//         iconSize: 40,
//         underline: Container(
//           height: 1,
//           color: Colors.transparent,
//         ),
//         onChanged: ( val) => setState(() => selection = val),
//         items: sampleList.map((option) {
//           return DropdownMenuItem(
//             value: option,
//             child: Container(
//                 width:double.infinity,
//                 alignment:Alignment.centerLeft,

//                 child:Text(option),
//                 decoration:BoxDecoration(
//                     border:Border(top:BorderSide(color:Colors.grey,width:1))
//                 )
//             ),
//           );
//         }).toList(),
//         selectedItemBuilder:(con){
//           return sampleList.map((m){
//             return Text(m,);
//           }).toList();
//         }
//     )
//     ),
//     )
//     ),
//     ),
//     );
//   }
// }