import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0.0,
    description: '',
    imageUrl: '',
    isFavorite: false
  );
  var _isInit = true;
  var _initialValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false).findById(productId);
        _initialValues['title'] = _editedProduct.title;
        _initialValues['description'] = _editedProduct.description;
        _initialValues['price'] = _editedProduct.price.toString();
        //_initialValues['imageUrl'] = _editedProduct.imageUrl;

        _imageUrlController.text = _editedProduct.imageUrl;
      }   
      _isInit = false;
    }
    
    super.didChangeDependencies();
  }

  @override 
  void dispose() {
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if(!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    if(_form.currentState.validate()) {
      _form.currentState.save();

      // Set loading to true for showing spinner
      setState(() {
        _isLoading = true;
      }); 

      if(_editedProduct.id != null) {   // editing an existing product
        // Set loading to false
        setState(() {
          _isLoading = true;
        }); 
        Provider.of<Products>(context, listen: false).updateProduct(_editedProduct);        
      } else {  // creating a new product
        try {
          await Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
        } catch(error) {
          await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Some error occurred'),
              content: Text('Something went wrong!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        } finally {
          // Set loading to false
          setState(() {
            _isLoading = true;
          }); 
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading ? 
        Center(
          child: CircularProgressIndicator(),
        ) :
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initialValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return value.isEmpty ? 'Please provide title' : null;  // Any non-NULL text returned means the error
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value, 
                      price: _editedProduct.price,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initialValues['price'],
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Please provide a value';
                    }
                    if(double.tryParse(value) == null) {
                      return 'Please provide a valid number';
                    } 
                    if(double.parse(value) <= 0) {
                      return 'Invalid price';
                    }
                    return null;  // Any non-NULL text returned means the error
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title, 
                      price: double.parse(value),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initialValues['description'],
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descFocusNode,
                  validator: (value) {
                    return value.isEmpty ? 'Please provide description' : null;  // Any non-NULL text returned means the error
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title, 
                      price: _editedProduct.price,
                      description: value,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1, 
                          color: Colors.grey,
                        )
                      ),
                      child: _imageUrlController.text.isEmpty ?
                        Text('Enter image URL') :
                        FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          // we can use regex also for valid urls
                          return value.isEmpty ? 'Please provide image url' : null;  // Any non-NULL text returned means the error
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title, 
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: value,
                            isFavorite: _editedProduct.isFavorite,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}