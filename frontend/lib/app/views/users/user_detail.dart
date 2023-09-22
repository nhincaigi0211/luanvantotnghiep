import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'user_grid.dart';
import '../../models/users.dart';
import '../../../route.dart';

class UserDetail extends StatefulWidget {
  static const routeName = '/user_detail';
  final User user;
  const UserDetail(this.user, {super.key});
  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late PickedFile _imageFile;
  File ? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final a = widget.user.Sum as dynamic;
    final List<Sum> ah = [];
    a.forEach((element) {
      ah.add(Sum.fromJson(element));
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Thông tin chi tiết'),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) =>[
                  PopupMenuItem(
                    child: Text('chỉnh sửa'),
                  ),
                  PopupMenuItem(
                    child: Text('Xóa'),
                  ),
                ]),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              imageProfile(context),
              const Divider(height: 15,),
              _title(widget.user.Name.toString(), Icons.account_circle),
              const Divider(
                height: 15,
              ),
              _title(widget.user.Phone.toString(), Icons.phone),
              const Divider(height: 15,),
              _title(widget.user.Address.toString(), Icons.map),
              const Divider(height: 15,),
              _title(widget.user.Email.toString(), Icons.email),
              const Divider(height: 15,),
              _title(ah[0].Ten.toString(), Icons.co2),
            ],
          ),
        ));
  }

  ListTile _title(String title, IconData icon) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }
  // Offset _tapPosition = Offset.zero;
  // void _getTapPosition(TapDownDetails tapDownDetails){
  //   final RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   setState(() {
  //     _tapPosition = renderBox.globalToLocal(tapDownDetails.globalPosition);
  //   });
  // }
  //
  // Future<void> _showContextMenu(context) async {
  //   final RenderObject? overlay = Overlay.of(context)?.context.findRenderObject();
  //   final result = await showMenu(
  //       context: context,
  //       position: RelativeRect.fromRect(
  //           Rect.fromLTWH(_tapPosition.dy, _tapPosition.dx, 20, 10),
  //           Rect.fromLTWH(
  //             0, 0, overlay!.paintBounds.size.width, overlay!.paintBounds.size.height
  //           ),
  //       ),
  //       items: [
  //         const PopupMenuItem(
  //           child: Text('Chỉnh sửa'),
  //         ),
  //         const PopupMenuItem(
  //             child: Text('Xóa'))
  //       ]);
  // }

  Future _pickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () {

                },
                child: Icon(Icons.camera),
              ),
              TextButton(
                  onPressed: (){
                    _pickImageFromGallery();
                  },
                  child: Icon(
                      Icons.image
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage("assets/avatar_1.jpg"),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: InkWell(
                onTap: () {

                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)
                    ),
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 28.0,
                )),
          )
        ],
      ),
    );
  }

}
