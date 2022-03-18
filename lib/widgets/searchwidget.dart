import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String>onChanged;
  const SearchWidget({Key? key,required this.onChanged,required this.text}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 48,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      child:
          TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            autofocus: true,
            controller: text,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    splashRadius: 20.0,
                    iconSize: 20.0,
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back_ios_rounded,
                  color: Theme.of(context).primaryColor,
                )),
                suffixIcon: text.text.isNotEmpty? GestureDetector(
                  child: Icon(Icons.clear_outlined,size: 18.0,
                    color: Colors.grey[600],
                  ),
                  onTap: (){
                    setState(() {
                      text.clear();
                      widget.onChanged('');
                    });
                  },
                ):null,
                fillColor: Colors.white,
                filled: true,
                hintText: "Search Food or Restuarants",
                hintStyle: TextStyle(
                    letterSpacing: 0.6,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(10.0)
                )
            ),
            onChanged: widget.onChanged,
          ),
    );
  }
}
