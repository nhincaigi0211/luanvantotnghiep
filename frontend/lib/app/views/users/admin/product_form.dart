import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../models/products.dart';
import '../../../../route.dart';

class ProductForm extends StatefulWidget{
  static const routeName = '/product_form';
  late final Product product;
  ProductForm(Product? product, {super.key}){
    if(product == null){
      this.product = Product(
      product_productId: '',
      product_Ma: '',
      product_Ten: '',
      product_MoTa: '',
      product_Price: 0,
      product_cmt: {},
      );
    }
    else{
     this.product = product;
    }
  }

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm>{
  var _isLoading = false;
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  @override
  void initState() {
    _editedProduct = widget.product;
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
                    buildTitleField(),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 150, child: buildPriceField()),
                        SizedBox(width: 150, child: buildCategoryField(),)
                      ],
                    ),
                    const SizedBox(height: 15,),
                    buildDescriptionField(),
                  ],
                ),
          ),
      ),
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.product_Price.toString(),
      decoration: InputDecoration(
        labelText: 'Giá sản phẩm',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(10.0),
          ),
        )
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'nhập gia vô';
        }
        if (double.tryParse(value) == null) {
          return 'nhập dúng giá';
        }
        if (double.parse(value) <= 0) {
          return 'nhập gia lớn hơn 0';
        }
        return null;
      },
      onSaved: (value) {
          _editedProduct =
              _editedProduct.coppyWith(product_Price: int.parse(value!));
      },
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.product_Ten,
      decoration: const InputDecoration(
        labelText: 'Tên sản phẩm',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'dien cai ten vo';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.coppyWith(product_Ten: value);
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.product_MoTa,
      decoration: const InputDecoration(
        labelText: 'Mô tả',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),
          )
        )
      ),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'dien cai mo ta vo';
        }
        if (value.length < 10) {
          return 'mo ta it nhat 10 ki tu';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.coppyWith(product_MoTa: value!);
      },
    );
  }

  TextFormField buildCategoryField() {
    return TextFormField(
      initialValue: _editedProduct.product_Ma,
      decoration: const InputDecoration(
          labelText: 'Mã sản phẩm',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          )),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'dien cai ten vo';
        }
        // if (value != 'Birthday' || value != 'Love') {
        //   return 'chi co hai loai hoa';
        // }
        return null;
      },
      onSaved: (value) {
        print(value);
        _editedProduct = _editedProduct.coppyWith(product_Ma: value);
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
      final productManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productManager.updateProduct(_editedProduct);
      } else {
        await productManager.addProduct(_editedProduct);
      }
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
        // _ShowConfirm();
      Navigator.of(context).pop();
    }
  }
  _ShowConfirm(){
    QuickAlert.show(
      context: context,
      title: 'Success',
      text: 'Chỉnh sửa thành công',
      type: QuickAlertType.success);

  }
}