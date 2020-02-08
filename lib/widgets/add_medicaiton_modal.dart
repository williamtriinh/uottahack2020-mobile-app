import "package:flutter/material.dart";

import "package:cloud_firestore/cloud_firestore.dart";

import "package:app/widgets/container_button.dart" as app;
import "package:app/widgets/outline_button.dart" as app;

class _addMedicationModal extends State<AddMedicationModal>
{
  final Firestore _firestore = Firestore.instance;
  final TextEditingController _textDrugEditingController = new TextEditingController();

  final List<String> _searchList = [];

  void _getAllDrugDocumentNames() async
  {
    if (_searchList.isNotEmpty)
    {
      return;
    }
    QuerySnapshot snapshot = await _firestore.collection("medication_info").getDocuments();
    snapshot.documents.forEach((doc) {
      _searchList.add(doc.documentID);
    });
  }

  void _updateList()
  {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x6D000000),
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _textDrugEditingController,
                  decoration: InputDecoration(
                    hintText: "Medication name"
                  ),
                  onTap: _getAllDrugDocumentNames,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Scheduled time",
                        style: TextStyle()
                      )
                    ),

                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "hh"
                            ),
                            style: TextStyle(
                              fontSize: 18,
                            )
                          ),
                        ),
                        Container(
                          width: 100,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "mm"
                            ),
                            style: TextStyle(
                              fontSize: 18,
                            )
                          ),
                        ),
                      ],
                    ),

                    Container(
                      height: 64.0
                    ),

                    app.ContainerButton(
                      label: "Add",
                      onPressed: widget.addData,
                    ),
                    app.OutlineButton(
                      label: "Cancel",
                      onPressed: widget.closeModal
                    )
                    
                  ],
                )
                

              ],
            )
          )
        ],
      )
    );
    // return Container(
    //   color: Color(0x6D000000),
    //   padding: EdgeInsets.all(24.0),
    //   child: Card(
    //     child: ListView(
    //       shrinkWrap: true,
    //       children: <Widget>[
    //         Container(
    //           margin: EdgeInsets.all(4.0),
    //           child: Column(
    //             children: <Widget>[

    //               TextField(
    //                 controller: _textDrugEditingController,
    //                 decoration: InputDecoration(
    //                   hintText: "Medication name"
    //                 ),
    //                 onTap: _getAllDrugDocumentNames,
    //               ),

    //               Row(
    //                 children: <Widget>[
    //                   Container(
    //                     width: 100,
    //                     child: TextField(
    //                       decoration: InputDecoration(
    //                         hintText: "hh"
    //                       ),
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                       )
    //                     ),
    //                   ),
    //                   Container(
    //                     width: 100,
    //                     child: TextField(
    //                       decoration: InputDecoration(
    //                         hintText: "mm"
    //                       ),
    //                       style: TextStyle(
    //                         fontSize: 18,
    //                       )
    //                     ),
    //                   ),
    //                 ],
    //               ),

    //               Spacer(),

    //               Row(
    //                 children: <Widget>[
    //                   app.ContainerButton(
    //                     label: "Cancel",
    //                     onPressed: () {

    //                     },
    //                   )
    //                 ],
    //               )

    //             ],
    //           ),
    //         ),
    //       ]
    //     ),
    //     elevation: 10
    //   )
    // );
  }
  
}

class AddMedicationModal extends StatefulWidget
{
  AddMedicationModal({this.addData, this.closeModal});
  final Function addData;
  final Function closeModal;

  @override
  _addMedicationModal createState() => _addMedicationModal();
}