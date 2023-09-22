import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../models/users.dart';
import '../../../../route.dart';

class UserForm extends StatefulWidget{
  static const routeName = '/user_form';
  late final User user;
  UserForm(User? user, {super.key}){
    if(user == null){
      this.user = User(
      Username: '',
      Name: '',
      Address: '',
      email: '',
      CapBac: '',
      Phone: '',
      pass: '',
      SoBan: 0,
      Sum: {},
      );
    }
    else{
     this.user = user;
    }
  }

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm>{
  var _isLoading = false;
  final _editForm = GlobalKey<FormState>();
  late User _editedUser;
  @override
  void initState() {
    _editedUser = widget.user;
    // _imageUrlController.text = _editedProduct.hinhsp;
    super.initState();
  }  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhập thông tin'),
        actions: [
          IconButton(
            onPressed: _saveForm, icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
      : Padding(
          padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 150, child: buildNameField()),
                        SizedBox(width: 150, child: buildPhoneField(),)
                      ],
                    ),
                    const SizedBox(height: 15,),
                    buildEmailField(),
                    const SizedBox(height: 15,),
                    buildAddressField(),
                  ],
                ),
          ),
      ),
    );
  }

  TextFormField buildNameField() {
    return TextFormField(
      initialValue: _editedUser.Name.toString(),
      decoration: const InputDecoration(
        labelText: 'Họ & Tên',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(10.0),
          ),
        )
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập tên';
        }
        return null;
      },
      onSaved: (value) {
          _editedUser =
              _editedUser.copyWith(Name: value);
      },
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      initialValue: _editedUser.Email,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập Email';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(email: value);
      },
    );
  }

  TextFormField buildAddressField() {
    return TextFormField(
      initialValue: _editedUser.Address,
      decoration: const InputDecoration(
        labelText: 'Địa chỉ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),
          )
        )
      ),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập địa chỉ';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(Address: value!);
      },
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      initialValue: _editedUser.Phone,
      decoration: const InputDecoration(
          labelText: 'Số điện thoại',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          )),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập số điện thoại';
        }
        return null;
      },
      onSaved: (value) {
        print(value);
        _editedUser = _editedUser.copyWith(Phone: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final usersManager = context.read<UsersManager>();
      if (_editedUser.id != null) {
        await usersManager.updateUser(_editedUser);
      } else {
        await usersManager.addUser(_editedUser);
      }
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}